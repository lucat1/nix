{ config, options, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    pavucontrol
    imv
    fend
  ];
}
