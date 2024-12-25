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
    fend
    brightnessctl

    comma

    (rebuild {pkgs = pkgs;})
  ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
