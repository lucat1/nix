{
  config,
  options,
  pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
    tray = true;
  };
}
