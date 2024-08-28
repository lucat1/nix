{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      env = [
        "XCURSOR_SIZE,32"
        "HYPRCURSOR_SIZE,32"
      ];
      animations = {
        enabled = false;
      };
      input = {
        repeat_rate = 40;
        repeat_delay = 300;
        kb_layout = "us,us(intl)";
        kb_options = "grp:shifts_toggle,caps:escape";
      };

      device = [
        {
          name = "msft0003:00-06cb:ce2d-touchpad";
          sensitivity = 0.1;
          accel_profile = "adaptive";

          natural_scroll = true;
          drag_lock = true;
        }
      ];

      misc = {
        vrr = true;
        vfr = true;
        no_direct_scanout = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_swallow = true;
        swallow_regex = "^(footclient|foot)$";
      };

      "$mod" = "SUPER";
      bind =
        [
          "$mod, Escape, exec, hyprlock -q"
          "$mod&ALT_L, 1, exec, scr"
          "$mod, Space, exec, bemenu-run"
          "$mod, Return, exec, footclient"
          "$mod, w, killactive,"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        )
        ++ [
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"
        ];
      bindle = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrevious, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86MonBrightnessUp, exec, light -A 2"
        ", XF86MonBrightnessDown, exec, light -U 2"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "float,class:(kitty)"
      ];
    };

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  # systemd.user.services.hyprland = {
  #   Unit = {
  #     Description = "Hyprland";
  #   };
  #   Install = {
  #     WantedBy = ["default.target"];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.hyprland}/bin/Hyprland";
  #     Restart = "always";
  #   };
  # };
}
