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
      colors = {
        background = vars.colors.bg;
        foreground = vars.colors.fg;
        regular0 = vars.colors.bg0;
        regular1 = vars.colors.red;
        regular2 = vars.colors.green;
        regular3 = vars.colors.yellow;
        regular4 = vars.colors.blue;
        regular5 = vars.colors.purple;
        regular6 = vars.colors.aqua;
        regular7 = vars.colors.gray;
        bright0 = vars.colors.lgray;
        bright1 = vars.colors.lred;
        bright2 = vars.colors.lgreen;
        bright3 = vars.colors.lyellow;
        bright4 = vars.colors.lblue;
        bright5 = vars.colors.lpurple;
        bright6 = vars.colors.laqua;
        bright7 = vars.colors.fg;
      };
    };
  };
}
