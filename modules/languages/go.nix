{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.go;
  goPath = "go";
  goBin = "${goPath}/bin";
in
{
  options = lib.neon.language.mkOptions "go";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      servers = [ "gopls" ];
      tsLanguages = [ "go" ];
    };

    home._ = {
      home.sessionPath = [ "$HOME/${goBin}" ];
      home.packages = with pkgs;[
        gopls
      ];
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
