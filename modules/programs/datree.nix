{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.datree;
in
{
  options = {
    neon.programs.datree = {
      enable = mkEnableOption "Enable datree cli";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        datree
      ];
    };
  };
}
