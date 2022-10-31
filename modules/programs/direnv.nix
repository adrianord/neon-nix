{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.direnv;
in
{
  options = {
    neon.programs.direnv = {
      enable = mkEnableOption "Enable direnv and nix-direnv";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;

        nix-direnv.enable = true;
      };
    };
  };
}
