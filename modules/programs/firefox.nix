{ config, lib, pkgs, userConf, ... }:

with lib;
let
  cfg = config.neon.programs.firefox;
in
{
  options = {
    neon.programs.firefox = {
      enable = mkEnableOption "Enable firefox";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.sessionVariables = {
          BROWSER = "firefox";
        };
        programs.firefox = {
          enable = true;
          package = pkgs.firefox-bin;
          profiles.${userConf.user.name} = {
            isDefault = true;
            path = userConf.user.name;
            settings = {
              "browser.fullscreen.autohide" = false;
              "browser.ctrlTab.sortByRecentlyUsed" = true;
            };
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            bitwarden
            darkreader
            multi-account-containers
            ublock-origin
            vimium-c
          ];
        };
        xdg.mimeApps = mkIf pkgs.stdenv.hostPlatform.isLinux {
          defaultApplications = {
            "text/html" = [ "firefox" ];
            "x-www-browser" = [ "firefox" ];
          };
        };
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        brews = [
          "firefoxpwa"
        ];
      };
    })
  ]);
}
