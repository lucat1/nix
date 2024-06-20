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
        dpi-aware = "no";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
