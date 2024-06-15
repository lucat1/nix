{ config, options, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "eza --header --git";
      ll = "eza -a --long --header --git";
      vi = "nvim";
      pass = "gopass";
    };

    prezto = {
      enable = true;
      editor = {
        keymap = "emacs";
      };
      pmodules = [
        "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
          "git"
          "syntax-highlighting"
          "autosuggestions"
      ];
      prompt = {
        theme = "skwp";
        pwdLength = "short";
        showReturnVal = true;
      };
    };
  };
}
