{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.neon.common.font;
in
{
  options = {
    neon.common.font = with types; {
      packages = mkOption {
        description = "Font packages to install";
        type = listOf package;
        default = with pkgs; [
          jetbrains-mono
        ];
      };
      default = mkOption {
        description = "Default font to use for programs managed by neon";
        type = str;
        default = "JetBrainsMono Nerd Font";
      };
      casks = mkOption {
        description = "Font casks to install if host platform is darwin";
        type = listOf str;
        default = [ "font-jetbrains-mono-nerd-font" ];
      };
      size = mkOption {
        description = "Size of the font";
        type = number;
        default = 13;
      };
    };
  };

  config = mkMerge [
    ({
      fonts.packages = cfg.packages;
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        taps = [ "homebrew/cask-fonts" ];
        casks = cfg.casks;
      };
    })
  ];
}
