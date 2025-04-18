{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  programs.git = {
    enable = true;

    lfs.enable = true;

    userName = vars.firstName;
    userEmail = vars.email;

    signing = {
      key = "3133FC373370010F";
      signByDefault = true;
    };

    aliases = {
      cm = "commit -m";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };

    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
      push = {autoSetupRemote = true;};

      # always use nvim as the editor
      core = {editor = "nvim";};
      diff = {editor = "nvimdiff";};
      merge = {editor = "nvimdiff";};
      mergetool."nvimdiff" = {path = "nvim";};
    };
  };
}
