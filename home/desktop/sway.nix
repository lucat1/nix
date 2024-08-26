{
  config,
  options,
  pkgs,
  lib,
  vars,
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

    config = rec {
      modifier = "Mod4";

      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.3";
          accel_profile = "adaptive";
          pointer_accel = "0.1";
        };
        "type:keyboard" = {
          repeat_rate = "40";
          repeat_delay = "300";
          xkb_layout = "us,us(intl)";
          xkb_options = "grp:shifts_toggle,caps:escape";
        };
      };

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
      menu = let
        menu = (import ../scripts/menu.nix) {
          pkgs = pkgs;
          vars = vars;
        };
      in "${lib.getExe menu} ${pkgs.bemenu}/bin/bemenu-run --no-exec -p run | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      keybindings = let
        scr = (import ../scripts/scr.nix) {pkgs = pkgs;};
        pws = (import ../scripts/pws.nix) {
          lib = lib;
          pkgs = pkgs;
          vars = vars;
        };
      in
        lib.mkOptionDefault {
          "${modifier}+w" = "kill";
          "${modifier}+space" = "exec ${menu}";
          "${modifier}+d" = null;
          "${modifier}+f" = "floating toggle";
          "${modifier}+Shift+f" = "fullscreen";

          "${modifier}+Alt+1" = "exec ${lib.getExe scr}";
          "${modifier}+p" = "exec ${lib.getExe pws}";
          "${modifier}+Escape" = "exec ${lib.getBin pkgs.hyprlock}";
        };

      bars = [];

      startup = map (service: {
        command = "${pkgs.systemd}/bin/systemctl --user reload-or-restart ${service}.service";
        always = true;
      }) ["kanshi" "waybar"];
    };

    systemd = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    wl-mirror
  ];
}
