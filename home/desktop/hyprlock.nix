{ config, options, pkgs, vars, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = false;
        no_fade_in = false;
        no_fade_out = true;
      };

      background = [
        {
          path = vars.homeDirectory + "/Pictures/wallpapers/current.jpg";
        }
      ];

      input-field = [
        {
          size = "300, 75";
          position = "0, -545";
          monitor = "";
          font_color = "rgb(235, 219, 178)";
          inner_color = "rgb(29, 32, 33)";
          outer_color = "rgb(40, 40, 40)";
          placeholder_text = "";
          rounding = 0;
          outline_thickness = 2;
          hide_input = true;
          fade_on_empty = true;
          fade_timeout = 0;
        }
      ];

      label = [
        {
          text = "$TIME";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 100;
          font_family = vars.fontFamilies.monospace;

          position = "0, 675";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:3600000] date +\"%a, %d %B\"";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 24;
          font_family = vars.fontFamilies.monospace;

          position = "0, 545";
          halign = "center";
          valign = "center";
        }
        {
          text = "Type to unlock";
          text_align = "center";
          color = "rgb(235, 219, 178)";
          font_size = 20;
          font_family = vars.fontFamilies.monospace;

          position = "0, -545";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
