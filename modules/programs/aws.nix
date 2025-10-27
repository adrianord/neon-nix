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
      home.sessionVariables = {
        AWS_VAULT_BIOMETRICS = "true";
      };
      programs.zsh = {
        initContent = ''
          complete -C 'aws_completer' aws
        '';
      };
    };
  };
}
