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
            position = "0,0";
            scale = 2.0;
          }
          {
            criteria = "HP Inc. HP Z27k G3 CN41271V20";
            position = "1440,540";
            scale = 1.5;
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
