{
  config,
  options,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = let
      proxmoxForward = {
        bind.port = 8006;
        host.address = "127.0.0.1";
        host.port = 8006;
      };
    in {
      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "honey" = {
        hostname = "honey.teapot.ovh";
        port = 2222;
        user = "root";
        localForwards = [proxmoxForward];
      };
      "picione" = {
        hostname = "honey.teapot.ovh";
        port = 2221;
        user = "root";
        localForwards = [proxmoxForward];
      };
      "kepler" = {
        hostname = "kepler.teapot.ovh";
        port = 2222;
        user = "root";
        localForwards = [proxmoxForward];
      };

      "eth-jump" = {
        hostname = "jumphost.inf.ethz.ch";
        user = "ltagliavini";
      };
      "*.ethz.ch !jumphost.inf.ethz.ch" = {
        proxyJump = "jumphost.inf.ethz.ch";
        user = "ltagliavini";
      };
    };
  };

  services.ssh-agent = {
    enable = true;
  };
}
