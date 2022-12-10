{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.terraform;
  vscodeEnable = config.neon.programs.vscode.enable;
in
{
  options = {
    neon.programs.terraform = {
      enable = mkEnableOption "Enable terraform";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        terraform
        terraformer
      ];
      programs.vscode = mkIf vscodeEnable {
        extensions = with pkgs.vscode-extensions; [
          hashicorp.terraform
        ];
      };
    };
  };
}
