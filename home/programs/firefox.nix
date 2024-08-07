{
  config,
  options,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        isDefault = true;
        userChrome = ''
          .titlebar-buttonbox-container {
            display: none
          }

          #alltabs-button {
            /*display: none !important;*/
            right: 0;
            top: 4px;
            position: fixed;
          }
        '';
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";

      Preferences = {
        # Privacy settings
        "extensions.pocket.enabled" = false;
        "browser.newtabpage.pinned" = "";
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true;
      };

      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "adnauseam@rednoise.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adnauseam/latest.xpi";
          installation_mode = "force_installed";
        };

        # youtube stuff
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-nonstop/latest.xpi";
          installation_mode = "force_installed";
        };
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
        };
        "browserpass@maximbaz.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/browserpass-ce/latest.xpi";
          installation_mode = "force_installed";
        };
        "addon@fastforward.team.xpi" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/fastforwardteam/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
