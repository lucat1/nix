{ config, options, pkgs, vars, ... }:

{
  services.mako = {
    enable = true;
    anchor = "bottom-right";
    
    font = "${vars.fontFamilies.monospace} ${toString vars.fontSize}";
    # TODO: styling, see available options at
    # https://github.com/nix-community/home-manager/blob/master/modules/services/mako.nix
  };
}
