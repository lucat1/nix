{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  programs.password-store = {
    enable = true;
    package = pkgs.gopass.override {passAlias = true;};
  };

  programs.browserpass = {
    enable = true;
    browsers = ["firefox"];
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
      pinentry = pkgs.pinentry-bemenu;
    };
  };
}
