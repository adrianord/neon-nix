{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.gcloud;
in
{
  options = {
    neon.programs.gcloud = {
      enable = mkEnableOption "Enable gcloud";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        google-cloud-sdk
      ];
    };
  };
}
