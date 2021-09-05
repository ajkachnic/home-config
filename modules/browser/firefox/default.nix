# Firefox rice
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.browser.firefox;
in {
  options.modules.browser.firefox = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden # Password manager
        decentraleyes # Host CDNs locally
        https-everywhere # Upgrade to https
        privacy-badger # Block evil trackers
        refined-github # Better github
        rust-search-extension # Rust search
        ublock-origin # Ad blocker
      ];

      profiles = {
        main = {
          name = "main";
          isDefault = true;
          settings = {
            "network.cookie.cookieBehavior" = 1; # Block third-party cookies

            # Disable telemetry
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.rejected" = true;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.unifiedIsOptIn" = false;
            "toolkit.telemetry.prompted" = 2;
            "toolkit.telemetry.server" = "";
            "toolkit.telemetry.cachedClientID" = "";
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.hybridContent.enabled" = false;
            "toolkit.telemetry.reportingpolicy.firstRun" = false;

            # Enable built-in tracking protection
            "privacy.trackingprotection.pbmode.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;

            # Send DNT
            "privacy.donottrackheader.enabled" = true;
            "privacy.donottrackheader.value" = 1;

            # STOP ASKING ABOUT MY DEFAULT BROWSER
            "browser.shell.checkDefaultBrowser" = false;
            # Disable auto-update (nix will handle it)
            "app.update.auto" = false;

            # Allow theming
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };

          # userChrome = builtins.readFile ./css/userChrome.css;
          # userContent = builtins.readFile ./css/userContent.css;
        };
      };
    };
  };
}
