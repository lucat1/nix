{
  config,
  options,
  pkgs,
  vars,
  ...
}: {
  services.fnott = {
    enable = true;
    settings = {
      main = {
        anchor = "bottom-right";
        selection-helper = "bemenu";
        dpi-aware = "no";

        body-font = vars.fontFamilies.monospace;
        title-font = vars.fontFamilies.monospace;
        summary-font = vars.fontFamilies.monospace;
      };
    };
  };
}
