{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  services.wlsunset = {
    enable = true;

    # Zürich coordinates
    latitude = 47.35953600;
    longitude = 8.63564520;
  };
}
