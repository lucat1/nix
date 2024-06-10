{ config, options, pkgs, vars, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.gopass;
  };

  programs.browserpass = {
    enable = true;
    browsers = [ "firefox" ];
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
[mounts "root"]
	path = ${vars.homeDirectory}/.password-store
[mounts "teapot"]
	path = ${vars.homeDirectory}/.local/share/teapot
[age]
	usekeychain = false
  '';
}
