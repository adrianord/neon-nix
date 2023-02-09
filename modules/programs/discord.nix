{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.discord;
in
{
  options = {
    neon.programs.discord = {
      enable = mkEnableOption "Enable discord";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf pkgs.stdenv.hostPlatform.isLinux {
      home._ = {
        home.packages = with pkgs; [
          discord-ptb
        ];
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "discord"
        ];
      };
    })
  ]);
}
