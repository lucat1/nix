{pkgs, ...}:
pkgs.writeShellApplication {
  name = "scr";

  runtimeInputs = with pkgs; [
    xdg-user-dirs
    grim
    slurp
    libnotify
  ];

  text = ''
    dir="$(xdg-user-dir PICTURES)/screens/$(date +%m-%d-%y)"

    if [ ! -d "$dir" ]; then
      mkdir -p "$dir"
    fi

    date=$(date +%m-%d-%y--%H-%M-%S.png)
    file="$dir/$date"
    grim -g "$(slurp -d)" "$file"

    size=$(du -sh "$file" | cut -f1)
    notify-send -t 2500 "Screenshot Taken - $size" "$file"
  '';
}
