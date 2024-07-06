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
    fend

    kicad
  ];

  # TODO
  # programs.nix-index-database.comma.enable = true;
}
