{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rebuild";

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
    read -p "Proceed [y/N]? " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi
    git add .
    echo "Rebuilding..."
    # shellcheck disable=SC2024
    sudo nixos-rebuild switch &> nixos-switch.log || (grep --color error < nixos-switch.log && exit 1)

    current=$(nixos-rebuild list-generations | grep current)

    git cm "$current"
    git push
    popd
    notify-send -e "NixOS Rebuild Successful"
  '';
}
