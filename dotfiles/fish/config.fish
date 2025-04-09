if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_function_path $fish_function_path "$XDG_CONFIG_HOME"/fish/plugin-foreign-env/functions

    # Nix Support?
    fenv source /etc/profile.d/nix.sh
end


set fish_greeting

# XDG

set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_STATE_HOME $HOME/.local/state
set -Ux GTK_THEME "Gruvbox-Yellow-Dark-Medium"

# Cleaning the $HOME
set -Ux HISTFILE "$XDG_STATE_HOME"/bash/history
set -Ux DOTNET_CLI_HOME "$XDG_DATA_HOME"/dotnet
set -Ux INPUTRC "$XDG_CONFIG_HOME"/readline/inputrc
set -Ux _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -Ux PYTHONSTARTUP "$XDG_CONFIG_HOME"/python/pythonrc

# Nix
alias man='/usr/bin/man' # I don't know...
