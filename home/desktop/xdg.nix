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

  # xdg.portal = let
  #   hyprland = config.wayland.windowManager.hyprland.package;
  #   xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  # in {
  #   enable = true;
  #   extraPortals = [xdph];
  #   configPackages = [hyprland];
  # };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];

    config = {
      hyprland = {
        default = [
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      };
    };
  };
}
