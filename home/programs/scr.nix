{
  config,
  options,
  pkgs,
  vars,
  ...
}: let
  scr = import ../scripts/scr.nix;
in {
  home.packages = with pkgs; [
    (scr {pkgs = pkgs;})
  ];
}
