{ config, options, pkgs, vars, ... }:

{
  programs.gpg = {
    enable = true;
    settings = {
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "auto-key-retrieve";
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-bemenu;
  };
}
