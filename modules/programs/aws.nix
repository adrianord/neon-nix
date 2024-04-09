{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.aws;
in
{
  options = {
    neon.programs.aws = {
      enable = mkEnableOption "Enable aws";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        awscli2
        aws-vault
      ];
      programs.zsh = {

        initExtra = ''
          complete -C 'aws_completer' aws
        '';
      };
    };
  };
}
