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
    $1 --fn "monospace ${toString vars.fontSize}" \
      --scrollbar autohide -l "10 down" --fixed-height --center \
      -W .75 -M 100 -B 2 --bdr "#${vars.colors.aqua}" \
      --tb "#${vars.colors.aqua}" --fb "#${vars.colors.bg}" \
      --nb "#${vars.colors.bg}" --hb "#${vars.colors.bg}" \
      --sb "#${vars.colors.bg}" --scb "#${vars.colors.bg}" \
      --tf "#${vars.colors.bg}" --ff "#${vars.colors.fg}" \
      --nf "#${vars.colors.fg}" --hf "#${vars.colors.aqua}" \
      --sf "#${vars.colors.aqua}" --scf "#${vars.colors.fg}" \
      "{@:2}"
  '';
}
