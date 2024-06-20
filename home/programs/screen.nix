{
  config,
  options,
  pkgs,
  vars,
  ...
}: let
  scr = pkgs.writeShellApplication {
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
      grim -g "$(slurp -d)" "$dir/$date"

      size=$(du -sh "$dir/$date" | awk '{print $1}')
      notify-send -t 5000 "screenshot taken - $size" "$date"
    '';
  };
in {
  home.packages = with pkgs; [
    scr
  ];
}
