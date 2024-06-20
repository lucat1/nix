{ config, options, pkgs, vars, ... }:

let scr = pkgs.writeShellApplication {
  name = "scr";

  runtimeInputs = with pkgs; [
    git
    alejandra
    libnotify
  ];

  text = ''
    pushd /etc/nixos

    # Early return if no changes were detected (thanks @singiamtel!)
    if git diff --quiet '*.nix'; then
        echo "No changes detected, exiting."
        popd
        exit 0
    fi

    alejandra . &>/dev/null \
      || ( alejandra . ; echo "formatting failed!" && exit 1)

    # Print changes
    git diff -U0 '*.nix'
    echo "Rebuilding..."
    sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

    current=$(nixos-rebuild list-generations | grep current)

    git cm "$current"
    popd
    notify-send -e "NixOS Rebuild Successful"
  '';
}; in
{
  home.packages = with pkgs; [
    scr
  ];
}

