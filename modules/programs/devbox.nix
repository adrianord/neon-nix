{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.devbox;
in
{
  options = {
    neon.programs.devbox = {
      enable = mkEnableOption "Enable devbox cli";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        devbox
      ];
    };
  };
}
