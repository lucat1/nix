{
  pkgs,
  vars,
  ...
}: let
  menu = (import ./menu.nix) {
    pkgs = pkgs;
    vars = vars;
  };
in
  pkgs.writeShellApplication {
    name = "pinentry";

    runtimeInputs = with pkgs; [
      pinentry-bemenu
      menu
    ];

    text = ''
      menu pinentry-bemenu
    '';
  }
