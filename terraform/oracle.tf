terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 8.0"
    }
  }
}

provider "oci" {
  config_file_profile = "DEFAULT"
}

# ============================================================
# Variables
# ============================================================

variable "compartment_ocid" {
  type        = string
  description = "OCI compartment containing the server"
}

variable "ssh_public_key" {
  type        = string
  description = "Path to SSH public key"
}

# ============================================================
# Availability Domain
# ============================================================

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

# ============================================================
# Latest Ubuntu 24.04 ARM image
# ============================================================

data "oci_core_images" "ubuntu_arm" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = "VM.Standard.A1.Flex"

  filter {
    name   = "display_name"
    values = ["^.*Ubuntu.*24\\.04.*aarch64.*$"]
    regex  = true
  }

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

# ============================================================
# VCN
# ============================================================

resource "oci_core_vcn" "main" {
  compartment_id = var.compartment_ocid

  cidr_block = "10.0.0.0/16"
  dns_label  = "mainvcn"

  display_name = "tofu-vcn"
}

# ============================================================
# Internet Gateway
# ============================================================

resource "oci_core_internet_gateway" "main" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  enabled      = true
  display_name = "tofu-internet-gateway"
}

# ============================================================
# Public Route Table
# ============================================================

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  display_name = "tofu-public-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.main.id
  }
}

# ============================================================
# Security List
# ============================================================

resource "oci_core_security_list" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  display_name = "tofu-public-security-list"

  # SSH
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 22
      max = 22
    }
  }

  # WireGuard
  ingress_security_rules {
    protocol    = "17"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    udp_options {
      min = 51820
      max = 51820
    }
  }

  # HTTP
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 80
      max = 80
    }
  }

  # HTTPS
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 443
      max = 443
    }
  }

  # Outbound
  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

# ============================================================
# Public Subnet
# ============================================================

resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id

  cidr_block = "10.0.0.0/24"

  route_table_id    = oci_core_route_table.public.id
  security_list_ids = [oci_core_security_list.public.id]

  prohibit_public_ip_on_vnic = false

  display_name = "tofu-public-subnet"
}

# ============================================================
# ARM Instance
# ============================================================
# FREE Ampere A1 allowance as of mid-2026: 2 OCPUs / 12 GB total.

resource "oci_core_instance" "server" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid

  display_name = "tofu-free-arm-deux"

  # Oracle Ampere A1
  shape = "VM.Standard.A1.Flex"

  # Maximum current Always Free allocation (2 OCPU / 12 GB total)
  shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  source_details {
    source_id   = data.oci_core_images.ubuntu_arm.images[0].id
    source_type = "image"

    # Maximum Always Free boot volume (unchanged, still 200 GB)
    boot_volume_size_in_gbs = 200
  }

  preserve_boot_volume = false
}

# ============================================================
# Outputs
# ============================================================

output "public_ip" {
  description = "Public IPv4 address of the server"
  value       = oci_core_instance.server.public_ip
}

output "instance_id" {
  description = "OCI instance OCID"
  value       = oci_core_instance.server.id
}

output "ssh_command" {
  description = "SSH command"
  value       = "ssh ubuntu@${oci_core_instance.server.public_ip}"
}
