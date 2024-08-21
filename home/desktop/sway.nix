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
        hideEdgeBorders = "smart";
        border = 2;
        titlebar = false;
      };

      gaps = let
        gap = 6;
      in {
        outer = gap;
        inner = gap - 2;
        smartGaps = true;
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
