{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.codeql;
in
{
  options = lib.neon.language.mkOptions "codeql";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        codeql
      ];
      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          GitHub.vscode-codeql
        ];
      };
    };
  };
}
