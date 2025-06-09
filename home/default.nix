{
  config,
  options,
  pkgs,
  vars,
  inputs,
  ...
}: {
  home.stateVersion = "23.11"; # Do not change
  programs.home-manager.enable = true;

  home.username = vars.user;
  home.homeDirectory = vars.homeDirectory;

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
  };

  imports = [
    # ./desktop/hyprland.nix
    ./desktop/sway.nix

    ./desktop/xdg.nix
    ./desktop/dark.nix
    ./desktop/fonts.nix

    ./desktop/hyprlock.nix
    ./desktop/hypridle.nix
    ./desktop/waybar.nix
    ./desktop/kanshi.nix
    ./desktop/hyprpaper.nix
    ./desktop/fnott.nix
    ./desktop/sunset.nix
    ./desktop/cliphist.nix

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
    ./programs/bat.nix
    ./programs/syncthing.nix
  ];

  home.packages = with pkgs; [
    zip
    unzip
    xz
    jq

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
    difftastic
    mergiraf

    imagemagick
    ghostscript # required by previous

    # inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.zotero-beta

    kubectl
    k9s
  ];

  programs.thunderbird = {
    enable = true;
    profiles = {};
  };
  programs.zathura.enable = true;
}
