{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "monospace:size=${toString vars.fontSize}";
        dpi-aware = false;
        pad = "4x4 center";
      };
      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
        protocols = "http,https,mailto";
      };
      mouse = {
        hide-when-typing = true;
        alternate-scroll-mode = true;
      };
    };
  };
}
