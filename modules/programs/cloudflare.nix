{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.cloudflare;
in
{
  options = {
    neon.programs.cloudflare = {
      enable = mkEnableOption "Enable cloudflare tools";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        nodePackages.wrangler
        worker-build
      ];
    };
  };
}
