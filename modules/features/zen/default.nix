{ self, inputs, ... }: {

  perSystem = { system, pkgs, lib, self', ... }: 
  let
    mkExtension = shortId: guid: {
      name = guid;
      value = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "normal_installed";
      };
    };

    prefs = { # about:config 
      "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = false;
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.discovery.enabled" = false;
      "browser.shell.checkDefaulBrowser" = false;
      "browser.preferences.moreFromMozilla" = false;
      "browser.ai.control.default" = "blocked";
      "browser.ml.enable" = false;
      "browser.download.open_pdf_attachments_inline" = true;
      "geo.provider.use_geoclue" = false;
      "browser.profiles.enabled" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "widget.dmabuf.force-enabled" = true;
    };

    extensions = [
      (mkExtension "ublock-origin" "uBlock0@raymondhill.net")
      (mkExtension "zen-internet" "{91aa3897-2634-4a8a-9092-279db23a7689}")
      (mkExtension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
    ];
  in
  {
    config.packages.myZen = (pkgs.wrapFirefox
      inputs.zen-browser.packages.${system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
	);

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "Youtube";
                URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                IconURL = "https://img.icons8.com/?size=100&id=19318&format=png&color=000000";
                Alias = "@yt";
              }
            ];
          };
        };
      }
    );
  };
}
