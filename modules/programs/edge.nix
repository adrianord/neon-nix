{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.edge;
in
{
  options = {
    neon.programs.edge = {
      enable = mkEnableOption "Enable edge";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux {
      home._ = {
        home.packages = with pkgs; [
          microsoft-edge-dev
        ];
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        taps = [
          "homebrew/cask-versions"
        ];
        casks = [
          "microsoft-edge-dev"
        ];
      };
    })

  ]);
}
