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
  programs.password-store = {
    enable = true;
    package = pkgs.gopass.override {passAlias = true;};
  };

  xdg.configFile."gopass/config".text = ''
    [core]
      notifications = true
    	cliptimeout = 45
    	showsafecontent = false
    	autoimport = true
    	parsing = true
    	nopager = false
    	exportkeys = true
    	autoclip = true
    [mounts "teapot"]
    	path = ${vars.homeDirectory}/.local/share/teapot
    [age]
    	usekeychain = false
  '';

  programs.rbw = {
    enable = true;

    settings = {
      email = vars.email;
      base_url = "https://vault.teapot.ovh";
      lock_timeout = 4 * 60 * 60; # 4 hours
      pinentry = pinentry;
    };
  };
}
