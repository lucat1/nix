{pkgs, ...}:
pkgs.writeShellApplication {
  name = "pws";

  runtimeInputs = with pkgs; [
    rbw
    bemenu
    wl-clipboard
    libnotify
    jq
  ];

  text = ''
    # This prints entries in a folder as $dir/$name, whereas directory-less items
    # are displayed as $name
    entry=$(rbw ls --fields folder,name \
      | awk -F "\t" 'length($1) > 0 {print $1 "/" $2} length($1) == 0 {print $2}' \
      | bemenu)
    folder=$(echo "$entry" | awk -F "/" 'length($2) > 0 {print $1} length($2) == 0 {print ""}')
    name=$(echo "$entry" | awk -F "/" 'length($2) > 0 {print $2} length($2) == 0 {print $1}')

    function rbw_action() {
      if [ "$folder" != "" ]; then
        rbw "$1" "$2" --folder "$folder" "$name"
      else
        rbw "$1" "$2" "$name"
      fi
    }

    if ! json=$(rbw_action get --raw); then
      notify-send -t 2500 "Could not read Bitwarden entry" "$entry"
      exit 1
    fi

    fields="password\nusername"
    totp=$(echo "$json" | jq ".data.totp")
    if [ "$totp" != "null" ]; then
      fields="password\nusername\notp"
    fi
    field=$(echo -e "$fields" | bemenu --auto-select)

    if [ "$field" == "otp" ]; then
      rbw_action "code" | wl-copy -o
    else
      echo "$json" | jq --join-output ".data.$field" | wl-copy -o # This way the data can be pasted only once
    fi
  '';
}
