{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    # settings = let builtin_display = "AU Optronics 0xC391"; in [
    settings = let
      builtin_display = "eDP-1";
    in [
      {
        profile.name = "standalone";
        profile.outputs = [
          {
            criteria = builtin_display;
            scale = 2.0;
          }
        ];
      }
      {
        profile.name = "dock-riccione";
        profile.outputs = [
          {
            criteria = builtin_display;
            status = "disable";
          }
          {
            criteria = "BNQ BenQ GW2470 H8F00852019";
            position = "0,0";
          }
          {
            criteria = "BNQ BenQ GW2470 H8F00853019";
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "dock-zurich";
        profile.outputs = [
          {
            criteria = builtin_display;
            status = "disable";
          }
          {
            criteria = "Samsung Electric Company SAMSUNG Unknown";
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "dock-ethz-cab";
        profile.outputs = [
          {
            criteria = builtin_display;
            position = "0,1080";
          }
          {
            criteria = "Lenovo Group Limited LEN-M90a-3-BA 0x00000001";
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "dock-unibo-pizzeria";
        profile.outputs = [
          {
            criteria = builtin_display;
            position = "0,1080";
          }
          {
            criteria = "Philips Consumer Electronics Company PHL 241B7Q 0x00002854";
            position = "0,0";
          }
        ];
      }
    ];
  };
}
