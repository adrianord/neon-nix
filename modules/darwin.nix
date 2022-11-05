{ config, lib, pkgs, userConf, ... }:

with lib;
let
  cfg = config.neon.darwin;
in
{
  options = {
    neon.darwin = {
      configure = mkEnableOption "Configure darwin Setting with nix-darwin";
      utils = {
        enable = mkEnableOption "Enable darwin Utils";
        includeUnfree = mkEnableOption "Enable utils that are require a license";
      };
    };
  };

  config = mkIf pkgs.stdenv.hostPlatform.isDarwin (mkMerge [
    ({
      services.nix-daemon.enable = true;
      programs.nix-index.enable = true;
      system.stateVersion = 4;

      homebrew = {
        enable = true;
        taps = [
          "homebrew/cask" # Explicitly set so cleanup doesn't try to remove
        ];
        onActivation = {
          cleanup = "uninstall";
        };
      };

      home._ = { config, pkgs, ... }: {
        home.file."Applications/Home Manager Apps".source =
          let
            apps = pkgs.buildEnv {
              name = "home-manager-applications";
              paths = config.home.packages;
              pathsToLink = "/Applications";
            };
          in
          "${apps}/Applications";
      };
      users.users.${userConf.user.name} = {
        name = userConf.user.name;
        home = "/Users/${userConf.user.name}";
      };
    })
    (mkIf cfg.utils.enable {
      homebrew.casks = [
        "raycast"
        "karabiner-elements"
        "alt-tab"
        "rectangle"
        "unnaturalscrollwheels"
      ];
    })
    (mkIf cfg.utils.includeUnfree {
      homebrew.casks = [
        "multitouch"
      ];
    })
    (mkIf cfg.configure {
      system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
      system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
      system.defaults.NSGlobalDomain.KeyRepeat = 2;
    })
  ]);
}
