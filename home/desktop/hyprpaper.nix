{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = [
        "${vars.homeDirectory + "/Pictures/wallpapers/current.jpg"}"
      ];
      wallpaper = [
        "eDP-1,${vars.homeDirectory + "/Pictures/wallpapers/current.jpg"}"
      ];
    };
  };
}
