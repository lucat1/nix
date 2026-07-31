{
  config,
  options,
  pkgs,
  vars,
  ...
}: rec {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4 = {
      theme = gtk.theme;
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
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
