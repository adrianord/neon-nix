{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.ansible;
in
{
  options = {
    neon.programs.ansible = {
      enable = mkEnableOption "Enable ansible";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        ansible
      ];
    };
  };
}
