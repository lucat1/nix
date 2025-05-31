{
  lib,
  config,
  options,
  pkgs,
  vars,
  ...
}: let
  pinentry = (import ../scripts/pinentry.nix) {
    lib = lib;
    pkgs = pkgs;
    vars = vars;
  };
in {
  programs.gpg = {
    enable = true;
    settings = {
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "auto-key-retrieve";
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pinentry;
    };
    defaultCacheTtl = 24 * 60 * 60; # one day
  };
}
