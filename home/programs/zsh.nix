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
      ls = "${pkgs.eza}/bin/eza --header --git";
      ll = "${pkgs.eza}/bin/eza -a --long --header --git";
      cat = "${pkgs.bat}/bin/bat -p";
      gd = "${pkgs.git}/bin/git diff --name-only --relative --diff-filter=d | ${pkgs.findutils}/bin/xargs ${pkgs.bat}/bin/bat --diff";
      dir = "${pkgs.yazi}/bin/yazi";
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
