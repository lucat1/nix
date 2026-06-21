{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    # adapt to 26.05
    gtk4.theme = null;
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    style = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
