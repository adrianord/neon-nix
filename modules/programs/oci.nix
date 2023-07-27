{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.oci;
in
{
  options = {
    neon.programs.oci = {
      enable = mkEnableOption "Enable oci";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        oci-cli
      ];
    };
  };
}
