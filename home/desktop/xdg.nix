{
  config,
  options,
  pkgs,
  ...
}: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];

    config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
        "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
      };
    };
  };
}
