{
  config,
  options,
  pkgs,
  ...
}: {
  services.syncthing = {
    # TODO: temporarily disabled
    enable = false;
    tray = false;
  };
}
