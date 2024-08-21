{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    config = {
      modifier = "Mod4";

      window = {
        hideEdgeBorders = "none";
        border = 2;
        titlebar = false;
      };

      gaps = {
        smartBorders = "no_gaps";
      };

      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.bemenu}/bin/bemenu-run --no-exec | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      bars = [];
    };

    systemd = {
      enable = true;
    };
  };
}
