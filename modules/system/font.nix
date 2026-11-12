# Font
{ inputs, config, ... }: {
  flake.nixosModules.font = { pkgs, ... }: {
    console.font = config.constants.font.console;
      
    fonts.fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
      localConf = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <match target="pattern">
         <edit name="dpi" mode="assign">
            <double>${config.constants.font.dpi}</double>
         </edit>
      </match>
    </fontconfig>
    '';
    };
  };
}
