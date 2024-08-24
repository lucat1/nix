{
  config,
  options,
  pkgs,
  ...
}: let
  scr = import ../scripts/scr.nix;
  rebuild = import ../scripts/rebuild.nix;
in {
  home.packages = with pkgs; [
    wl-clipboard
    pavucontrol
    imv
    imv
    fend

    # kicad

    (scr {pkgs = pkgs;})
    (rebuild {pkgs = pkgs;})
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;
}
