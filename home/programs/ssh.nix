{ config, options, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "honey" = {
        hostname = "honey.teapot.ovh";
        port = 2222;
        user = "root";
        localForwards = [
          {
            bind.port = 8006;
            host.address = "127.0.0.1";
            host.port = 8006;
          }
        ];
      };
      "kepler" = {
        hostname = "kepler.teapot.ovh";
        port = 2222;
        user = "root";
        localForwards = [
          {
            bind.port = 8006;
            host.address = "127.0.0.1";
            host.port = 8006;
          }
        ];
      };
    };
  };

  services.ssh-agent = {
    enable = true;
  };
}
