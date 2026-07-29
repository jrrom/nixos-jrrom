# Font
{ inputs, ... }: {
  flake.nixosModules.font = { pkgs, ... }: {
    console = {
      font = "Lat2-Terminus16";
    };
      
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";  # try "rgb" first, or "bgr" if that looks worse
        lcdfilter = "default";
      };
      localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <match target="pattern">
         <edit name="dpi" mode="assign">
            <double>142</double>
         </edit>
      </match>
    </fontconfig>
    '';
    };

    fonts.packages = with pkgs; [
      maple-mono.truetype
      nerd-fonts.symbols-only
    ];
  };
}
