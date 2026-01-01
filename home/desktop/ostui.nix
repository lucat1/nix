{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ostui
  ];

  home.file = {
    ".config/ostui/config".source = ''
      [auth]
      username = 'luca'
      password = 'password'
      plaintext = true

      [server]
      host = 'https://music.teapot.ovh'
      scrobble = true
    '';
  };
}
