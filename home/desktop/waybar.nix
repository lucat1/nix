{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "bottom";
        height = 22;
        modules-left = ["sway/workspaces"];
        modules-right = ["sway/language" "network" "pulseaudio" "backlight" "battery" "clock"];

        "sway/workspaces" = {
          format = "{icon}";
        };
        "sway/language" = {
          format = "{short} ({variant})";
        };

        "network" = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "";
          on-click = "${pkgs.foot}/bin/footclient -T nmtui ${pkgs.networkmanager}/bin/nmtui";
          tooltip-format-wifi = "{ifname} ({essid}): {ipaddr}/{cidr} via {gwaddr}";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr} via {gwaddr}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = ["" "" ""];
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "backlight" = {
          format = " {percent}%";
        };
        "battery" = {
          "states" = {
            good = 95;
            warning = 30;
            critical = 2;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂏 {capacity}%";
          format-plugged = "󰁹 {capacity}%";
          format-icons = [" " " " " " " " " "];
        };
        "clock" = {
          tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };

    style = ''
          * {
        border: none;
        border-radius: 0;
        font-family: monospace;
        font-size: ${toString vars.barFontSize}px;
        min-height: 0;
      }

      window#waybar,
      #mode,
      #workspaces button,
      #pulseaudio,
      #network,
      #backlight,
      #battery,
      #clock {
        background: #${vars.colors.bg};
        color: #${vars.colors.fg};
        padding: 0 8px;
        margin: 0 8px;
      }

      #mode, #workspaces button, #clock {
        margin: 0;
      }

      #mode {
        color: #${vars.colors.fg};
        background: #${vars.colors.aqua};
      }

      #workspaces button.focused,
      #battery.charging,
      #battery.plugged {
        color: #${vars.colors.bg};
        background: #${vars.colors.aqua};
      }

      @keyframes blink {
        to {
          color: #${vars.colors.fg};
          background: #${vars.colors.red};
        }
      }

      #battery.warning:not(.charging) {
        color: #${vars.colors.fg};
        background: #${vars.colors.yellow};
      }

      #battery.critical:not(.charging) {
        color: #${vars.colors.fg};
        background: #cc241d;
        animation-name: blink;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
    '';

    systemd = {
      enable = true;
    };
  };
}
