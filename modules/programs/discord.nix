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

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        discord-ptb
      ];
    };
  };
}
