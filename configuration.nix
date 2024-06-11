# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let vars = import ./vars.nix; in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  system.stateVersion = "23.11"; # Do not change
  system.autoUpgrade.enable  = true;
  hardware.opengl.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true; 
  systemd.services.nssd.enable = false;
  systemd.services.nssd.wantedBy = lib.mkForce [];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.zsh.enable = true;
  users.users."${vars.user}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };
  services.getty.autologinUser = vars.user;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    neovim
    ripgrep
    htop
    curl
    git
    killall
    pciutils
  ];
  programs.light.enable = true;

  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  fonts.fontDir.enable = true;
  programs.dconf.enable = true;
  services.tlp.enable = true;
}
