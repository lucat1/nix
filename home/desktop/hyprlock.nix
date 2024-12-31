{
  config,
  options,
  pkgs,
  lib,
  vars,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = false;
        immediate_render = true;
        no_fade_in = true;
        no_fade_out = true;
      };

      background = [
        {
          path = vars.homeDirectory + "/Pictures/wallpapers/current.jpg";
        }
      ];

      input-field = [
        {
          font_color = "rgb(235, 219, 178)";
          inner_color = "rgb(29, 32, 33)";
          outer_color = "rgb(40, 40, 40)";
          placeholder_text = "";
          rounding = 0;
          outline_thickness = 2;
          hide_input = true;
          fade_on_empty = true;
          fade_timeout = 0;

          size = "350%, 75%";
          halign = "center";
          valign = "center";
          position = "0, -420%";
        }
      ];

      label = [
        {
          text = "$TIME";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 100;
          font_family = vars.fontFamilies.monospace;

          halign = "center";
          valign = "center";
          position = "0, 420%";
        }
        {
          text = "cmd[update:3600000] ${lib.getExe' pkgs.coreutils "date"} +\"%a, %d %B\"";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 24;
          font_family = vars.fontFamilies.monospace;

          halign = "center";
          valign = "center";
          position = "0, 300%";
        }
        {
          text = "Type to unlock";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 20;
          font_family = vars.fontFamilies.monospace;

          halign = "center";
          valign = "center";
          position = "0, -420%";
        }
      ];
    };
  };
}
