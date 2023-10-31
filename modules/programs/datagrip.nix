{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.datagrip;
in
{
  options = {
    neon.programs.datagrip = {
      enable = mkEnableOption "Enable datagrip";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        jetbrains.datagrip
      ];
    };
  };
}
