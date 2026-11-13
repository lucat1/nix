{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: let
  opencode = inputs.opencode.packages.x86_64-linux.opencode;
in {
  programs.opencode = {
    enable = true;
    package = opencode;
  };
}
