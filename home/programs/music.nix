{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "/home/jrrom/HD/Muzik";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire output"
      }
    '';
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";

      lyrics_directory = "/home/jrrom/HD/Lyrics";

      visualizer_type = "ellipse";
      visualizer_look = "●●";
      # visualizer_color = "33,39,63,75,81,99,117,153,189"
      visualizer_spectrum_smooth_look = "no";

      cyclic_scrolling = "yes";
      # external_editor = "nvim";

      # PROGRESS BAR
      # ---
      progressbar_look = "▪▪▪";
      #progressbar_look = "▃▃▃";
      progressbar_elapsed_color = "yellow";
      progressbar_color = "white";

      # UI VISIBILITY
      # ---
      header_visibility = "no";
      statusbar_visibility = "yes";
      titles_visibility = "no";
      enable_window_title = "yes";
    };
    bindings = [
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "h"; command = "previous_column"; }
      { key = "l"; command = "next_column"; }
      { key = "ctrl-l"; command = "show_lyrics"; }
      { key = "shift-+"; command = "volume_up"; }
      { key = "shift--"; command = "volume_down";}
    ];
  };
}
