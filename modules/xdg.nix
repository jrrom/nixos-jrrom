let
  XDG_CACHE_HOME  = "$HOME/.cache";
  XDG_CONFIG_HOME = "$HOME/.config";
  XDG_DATA_HOME   = "$HOME/.local/share";
  XDG_STATE_HOME  = "$HOME/.local/state";
in
{ inputs, ... }: {
  flake.nixosModules.xdg = { pkgs, ... }: {
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";

      ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
      ANDROID_AVD_HOME  = "${XDG_DATA_HOME}/android/avd";
      HISTFILE          = "$HOME/.local/state/bash/history";
      PYTHON_HISTORY    = "${XDG_STATE_HOME}/python_history";
      
      _JAVA_OPTIONS     = "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle";

      DOTNET_CLI_HOME        = "${XDG_DATA_HOME}/dotnet";
      NPM_CONFIG_INIT_MODULE = "${XDG_CONFIG_HOME}/npm/config/npm-init.js";
      NPM_CONFIG_CACHE       = "${XDG_CACHE_HOME}/npm";
      NPM_CONFIG_TMP         = "$XDG_RUNTIME_DIR/npm";
      
      AIDER_CONFIG_FILE = "${XDG_CONFIG_HOME}/aider/config.yml";
      AIDER_DARK_MODE   = "true";
      JULIA_DEPOT_PATH  = "${XDG_DATA_HOME}/julia:$JULIA_DEPOT_PATH";
    };

    environment.shellAliases = {
      wget = "wget --hsts-file=${XDG_DATA_HOME}/wget-hsts";
    };
  };
}
