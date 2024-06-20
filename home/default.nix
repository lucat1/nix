{ config, options, pkgs, vars, ... }:

{
  home.stateVersion = "23.11"; # Do not change
  programs.home-manager.enable = true;

  home.username = vars.user;
  home.homeDirectory = vars.homeDirectory;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };


  imports = [
    ./desktop/xdg.nix
    ./desktop/dark.nix
    ./desktop/fonts.nix
    ./desktop/hyprland.nix
    ./desktop/hyprlock.nix
    ./desktop/hyprpaper.nix
    ./desktop/kanshi.nix
    ./desktop/waybar.nix
    ./desktop/mako.nix
    
    ./programs/zsh.nix
    ./programs/direnv.nix
    ./programs/ssh.nix
    ./programs/gpg.nix
    ./programs/git.nix
    ./programs/pass.nix
    ./programs/bemenu.nix
    ./programs/firefox.nix
    ./programs/foot.nix
    ./programs/nvim.nix

    ./programs/basic.nix
    ./programs/screen.nix
    ./programs/rebuild.nix
  ];

  home.packages = with pkgs; [
    zip
    unzip
    xz

    jq
    eza

    iperf3
    dnsutils
    ldns
    nmap

    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    imagemagick
  ];

  programs.thunderbird = {
    enable = true;
    profiles = {};
  };
  programs.zathura.enable = true;
  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
  };

  fonts.fontconfig.enable = true;

  # services.hypridle = {
  #   enable = true;
  # };
}
