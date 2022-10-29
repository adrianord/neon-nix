{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.go;
in
{
  options = lib.neon.language.mkOptions "go";

  config = mkIf cfg.enable {
    home._ = {
      home.sessionPath = [ "$HOME/${goBin}" ];
      programs = {
        go = {
          enable = true;
          package = pkgs.go_1_19;
          inherit goPath goBin;
        };
        vscode = mkIf cfg.vscode.enable {
          extensions = with pkgs.vscode-extensions; [
            golang.go
          ];
        };
      };
    };
  };
}
