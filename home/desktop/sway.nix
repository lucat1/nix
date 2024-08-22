{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

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
        gap = 4;
      in {
        outer = gap;
        inner = gap * 2;
        smartGaps = true;
        smartBorders = "on";
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
