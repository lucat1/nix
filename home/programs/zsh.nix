{
  config,
  options,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "eza --header --git";
      ll = "eza -a --long --header --git";
      cat = "bat -p";
      gd = "git diff --name-only --relative --diff-filter=d | xargs bat --diff";

      vi = "nvim";
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
