{
  config,
  options,
  pkgs,
  lib,
  vars,
  ...
}: let
  xkbKeymap = pkgs.writeText "apple-keymap" ''
    xkb_keymap {
      xkb_keycodes  {
        include "evdev+aliases(qwerty)"
        // Map KEY_FN (464) to a keycode, then alias it to RCTL
        <I464> = 464;
        alias <FK01> = <I464>;
      };
      xkb_types     { include "complete" };
      xkb_compat    { include "complete" };
      xkb_symbols   {
        include "pc+us+us(intl):2+inet(evdev)+altwin(swap_alt_win)+capslock(escape)+group(shifts_toggle)"

        // Make FK01 act as Right Control
        key <FK01> { [ Control_R, Control_R ] };

        // Swap grave/tilde with less/greater
        replace key <TLDE> { [ less, greater, less, greater ] };
        replace key <LSGT> { [ grave, asciitilde, grave, asciitilde ] };
      };
      xkb_geometry  { include "pc(pc105)" };
    };
  '';
in {
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    config = let
      cmenu = (import ../scripts/menu.nix) {
        pkgs = pkgs;
        vars = vars;
      };
    in rec {
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
        "1452:542:Apple_Inc._Apple_Keyboard" = {
          xkb_file = "${xkbKeymap}";
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

      terminal = "${lib.getExe' pkgs.foot "footclient"}";
      menu = "${lib.getExe cmenu} ${lib.getExe' pkgs.bemenu "bemenu-run"} --no-exec -p run | ${lib.getExe' pkgs.findutils "xargs"} ${lib.getExe' pkgs.sway "swaymsg"} exec --";

      keybindings = let
        scr = (import ../scripts/scr.nix) {pkgs = pkgs;};
        pws = (import ../scripts/pws.nix) {
          lib = lib;
          pkgs = pkgs;
          vars = vars;
        };
        clip = let
          cliphist = lib.getExe' pkgs.cliphist "cliphist";
        in "${cliphist} list | ${lib.getExe cmenu} ${lib.getExe' pkgs.bemenu "bemenu"} -p clip | ${cliphist} decode |  ${lib.getExe' pkgs.wl-clipboard "wl-copy"}";
      in
        lib.mkOptionDefault {
          "${modifier}+w" = "kill";
          "${modifier}+space" = "exec ${menu}";
          "${modifier}+c" = "exec ${clip}";
          "${modifier}+d" = null;
          "${modifier}+f" = "floating toggle";
          "${modifier}+Shift+f" = "fullscreen";

          "${modifier}+Alt+1" = "exec ${lib.getExe scr}";
          "${modifier}+p" = "exec ${lib.getExe pws}";
          "${modifier}+Escape" = "exec ${lib.getExe' pkgs.systemd "loginctl"} lock-session";

          "XF86AudioMute" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+";
          "XF86AudioLowerVolume" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-";
          "XF86AudioMicMute" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play";
          "XF86AudioNext" = "exec ${lib.getExe pkgs.playerctl} next";
          "XF86AudioPrev" = "exec ${lib.getExe pkgs.playerctl} previous";
          "XF86AudioStop" = "exec ${lib.getExe pkgs.playerctl} stop";
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set 2%+";
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set 2%-";
        };

      bars = [];

      startup = map (service: {
        command = "${lib.getExe' pkgs.systemd "systemctl"} --user reload-or-restart ${service}.service";
        always = true;
      }) ["kanshi" "waybar"];
    };

    extraConfig = ''
      for_window {
        [window_role="pop-up"] floating enable
        [window_role="bubble"] floating enable
        [window_role="dialog"] floating enable
        [window_type="dialog"] floating enable
        [app_id="firefox" title=".+\(Bitwarden Password Manager\).+"] floating enable
        [app_id="thunderbird" title="Write: .+"] floating enable
      }
    '';

    systemd = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    wl-mirror
  ];
}
