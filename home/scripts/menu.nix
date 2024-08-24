{
  pkgs,
  vars,
  ...
}:
pkgs.writeShellApplication {
  name = "menu";

  runtimeInputs = with pkgs; [
    bemenu
  ];

  text = ''
    $1 --fn "monospace ${toString vars.fontSize}" --scrollbar autohide -l "10 down" --fixed-height --center -W .75 -M 100 -B 2 "{@:2}"
  '';
}
