{
  config,
  options,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    pavucontrol
    imv
    yazi
    fend

    # kicad
  ];

  # TODO
  # programs.nix-index-database.comma.enable = true;
}
