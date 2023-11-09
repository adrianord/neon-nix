{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.vivaldi;
in
{
  options = {
    neon.programs.vivaldi = {
      enable = mkEnableOption "Enable vivaldi";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux {
      home._ = {
        home.packages = with pkgs; [
          vivaldi
        ];
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "vivaldi"
        ];
      };
    })

  ]);
}
