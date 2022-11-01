{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.pulumi;
in
{
  options = {
    neon.programs.pulumi = {
      enable = mkEnableOption "Enable pulumi";
    };
  };

  config = mkIf cfg.enable {
    home._.home.packages = with pkgs; [
      pulumi-bin
      pulumictl
    ];
  };
}
