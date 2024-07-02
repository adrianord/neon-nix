{ config, lib, pkgs, userConf, ... }:

with lib;
let
  cfg = config.neon.programs.zellij;
in
{
  options = {
    neon.programs.zellij = {
      enable = mkEnableOption "zellij";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      programs.zellij = {
        enable = true;
        enableZshIntegration = config.neon.programs.zsh.enable;
        settings = {
          mouse_mode = false;
        };
      };
    };
  };

}
