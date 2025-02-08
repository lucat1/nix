{
  lib,
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
      menu
    ];

    text = ''
      echo "OK Pleased to meet you"

      while read -r stdin; do
        case $stdin in
          *BYE*) echo "OK closing connection"; break ;;
          *SETDESC*) KEYNAME=''${stdin#*:%0A%22}; KEYNAME=''${KEYNAME%\%22\%0A*}; KEYID=''${stdin#*ID }; KEYID=''${KEYID%,*}; echo OK ;;
          *GETPIN*) PASS=$(echo "" | ${lib.getExe menu} ${lib.getExe pkgs.bemenu} -x hide -p "gpg($KEYNAME):");echo "D $PASS"; echo "OK" ;;
          *) echo OK
        esac
      done
    '';
  }
