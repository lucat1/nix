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

  text = let
    rest = "\${@:2}";
  in ''
    $1 -i --fn "monospace ${toString vars.fontSize}" \
      -l "10 down" --fixed-height --center \
      -W .75 -M 100 -B 2 --bdr "#${vars.colors.aqua}" \
      --tb "#${vars.colors.aqua}" --fb "#${vars.colors.bg}" \
      --nb "#${vars.colors.bg}" --hb "#${vars.colors.bg0}" --ab "#${vars.colors.bg}" \
      --sb "#${vars.colors.bg}" --scb "#${vars.colors.bg}" \
      --tf "#${vars.colors.bg}" --ff "#${vars.colors.fg}" \
      --nf "#${vars.colors.fg}" --hf "#${vars.colors.aqua}" --af "#${vars.colors.fg}" \
      --sf "#${vars.colors.aqua}" --scf "#${vars.colors.purple}" \
      "${rest}"
  '';
}
