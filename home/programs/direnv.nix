{ config, options, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  services.lorri = {
    enable = true;
    enableNotifications = true;
  };
}
