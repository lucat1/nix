{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = vars.fontFamilies.monospace;
    };
  };

  home.packages = with pkgs; [
    roboto
    noto-fonts
    noto-fonts-extra
    noto-fonts-cjk-sans
    nerd-fonts.blex-mono
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [vars.fontFamilies.monospace];
        serif = [vars.fontFamilies.serif];
        sansSerif = [vars.fontFamilies.sansSerif];
      };
    };
  };
}
