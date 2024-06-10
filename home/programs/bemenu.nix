{ config, options, pkgs, ... }:

{
  programs.bemenu = {
    enable = true;
    settings = {
      line-height = 20;
      prompt = "open";
      ignorecase = true;
    };
  };
}

