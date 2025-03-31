#!/bin/sh

# Managed by HSETC

USER="jrrom"
XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
WAYLAND_DISPLAY="wayland-1" # Try "wayland-0" if this doesn't work

export XDG_RUNTIME_DIR
export WAYLAND_DISPLAY

# Run swaylock as the user
su -c "swaylock" $USER &

