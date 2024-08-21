rec {
  hostname = "voodoo";
  user = "luca";
  firstName = "Luca";
  email = "luca@teapot.ovh";
  homeDirectory = "/home/${user}";
  arch = "x86_64-linux";

  fontSize = 12;
  fontFamilies = {
    monospace = "BlexMono Nerd Font";
    serif = "Roboto";
    sansSerif = "Roboto";
  };
  barFontSize = 16;
  colors = rec {
    bg0 = "282828";
    bg0_hard = "1d2021";
    bg = bg0_hard;
    fg = "ebdbb2";

    aqua = "689d6a";
    blue = "458588";
    gray = "a89984";
    green = "98971a";
    purple = "b16286";
    red = "cc341d";
    yellow = "d79921";

    laqua = "8ec97c";
    lblue = "83a598";
    lgray = "928374";
    lgreen = "b8bb26";
    lpurple = "d3869b";
    lred = "fb4934";
    lyellow = "fabd2f";
  };
}
