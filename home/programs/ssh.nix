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
        port = 2220;
        user = "root";
        localForwards = [proxmoxForward];
      };
      "kepler" = {
        hostname = "kepler.teapot.ovh";
        port = 2222;
        user = "root";
        localForwards = [proxmoxForward];
      };
      "mocha" = {
        hostname = "cappuccino.ovh";
        port = 2222;
        user = "root";
      };

      "eth-jump" = {
        user = "ltagliavini";
        hostname = "jumphost.inf.ethz.ch";
      };
      "alveo-*.ethz.ch" = {
        user = "ltagliavini";
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "*.ethz.ch !jumphost.inf.ethz.ch !alveo-*.ethz.ch" = {
        user = "ltagliavini";
        proxyJump = "eth-jump";
      };
    };
  };

  services.ssh-agent = {
    enable = true;
  };
}
