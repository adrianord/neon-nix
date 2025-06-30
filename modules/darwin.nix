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
      programs.nix-index.enable = true;
      system.stateVersion = 4;
      system.primaryUser = userConf.user.name;
      documentation.enable = false;

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          upgrade = false;
          cleanup = "uninstall";
        };

        global = {
          autoUpdate = false;
        };
      };

      home._ = { config, pkgs, ... }: {
        home.sessionPath = mkIf (userConf.host.arch == "aarch64") [ "/opt/homebrew/bin" ];
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
        "topnotch"
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

    (mkIf config.neon.programs.zsh.enable {
      homebrew.brews = [
        "zsh-completions"
      ];
      home._.programs.zsh = {
        initContent = lib.mkOrder 550 ''
          if type brew &>/dev/null; then
            eval "$(brew shellenv)"
            FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

            autoload -Uz compinit
            compinit
          fi
        '';
      };
    })
  ]);
}
