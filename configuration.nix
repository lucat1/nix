# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: let
  vars = import ./vars.nix;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11"; # Do not change

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  # to have nat64 capability
  boot.extraModulePackages = with config.boot.kernelPackages; [jool];

  networking = {
    hostName = vars.hostname;
    firewall = {
      enable = true;
      logReversePathDrops = true;
    };
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        scanRandMacAddress = true;
        macAddress = "random"; # "stable-ssid";
      };
      settings = {
        connectivity = {
          interval = 0;
        };
      };
      plugins = with pkgs; [
        # ensure we have priorietary VPN support
        networkmanager-openconnect
      ];
    };
  };
  services.resolved = {
    enable = true;
    dnssec = "false"; # "allow-downgrade";
    domains = []; # ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    dnsovertls = "false"; # "opportunistic";
    extraConfig = "
    MulticastDNS=false
    ";
  };
  systemd.services.nssd = {
    enable = false;
    wantedBy = lib.mkForce [];
  };
  services.clatd.enable = true;
  # services.dnscrypt-proxy2 = {
  #   enable = true;
  #   settings = {
  #     ipv6_servers = true;
  #     require_dnssec = true;
  #
  #     dnscrypt_servers = false;
  #     doh_servers = true;
  #     odoh_servers = true;
  #     require_nolog = true;
  #     require_nofilter = true;
  #
  #     sources.public-resolvers = {
  #       urls = [
  #         "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #         "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #         "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/odoh-resolvers.md"
  #       ];
  #       cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
  #       minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #     };
  #
  #     # From https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
  #     server_names = [
  #       "odohrelay-ibksturm" # Switzerland
  #       "odohrelay-ams" # Amsterdam
  #       "odohrelay-se" # Sweden
  #
  #       "quad9-doh-ip4-port443-nofilter-pri"
  #       "quad9-doh-ip4-port5053-filter-pri"
  #       # "quad9-doh-ip6-port443-nofilter-pri"
  #       # "quad9-doh-ip6-port5053-filter-pri"
  #
  #       "cloudflare"
  #       # "cloudflare-ipv6"
  #     ];
  #   };
  # };
  # systemd.services.dnscrypt-proxy2.serviceConfig = {
  #   StateDirectory = "dnscrypt-proxy";
  # };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.samsung-unified-linux-driver
  ];
  hardware.sane.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.dbus.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    raopOpenFirewall = true;
    extraConfig.pipewire = {
      "99-focusrite-adjust-sample-rate" = {
        "context.properties" = {
          "default.clock.rate" = 44100; # frequency required by the Focursite Scarlett Solo
          "defautlt.allowed-rates" = [192000 176400 96000 88200 48000 44100];
        };
      };
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";

            args = {
              "raop.latency.ms" = 1000;
            };
          }
        ];
      };
    };
  };

  # User setup
  programs.zsh.enable = true;
  users.groups."${vars.user}" = {};
  users.users."${vars.user}" = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" vars.user "scanner" "lp" "networkmanager"];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;
  services.greetd = {
    enable = true;
    settings = rec {
      # initial_session = {
      #   command = "${pkgs.hyprland}/bin/Hyprland";
      #   user = vars.user;
      # };
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = vars.user;
      };
      default_session = initial_session;
    };
  };
  # To make the xdg-desktop-portal installed by home-manager work
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  # misc
  environment.systemPackages = with pkgs; [
    neovim
    ripgrep
    jless
    htop
    curl
    git
    killall
    pciutils

    docker-compose
  ];
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "12:00";
  };
  fonts.fontDir.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };

  # ew
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # services.tailscale.enable = true;
  # services.tailscale.useRoutingFeatures = "client";
  # networking.firewall.enable = false;

  services.udev.extraHwdb = ''
    evdev:input:b0003v05ACp021E*
     KEYBOARD_KEY_ff0003=rightctrl
  '';
}
