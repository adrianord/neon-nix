{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.go;
  goPath = "go";
  goBin = "${goPath}/bin";
in
{
  options = lib.neon.mkLanguageOptions config "go";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.sessionPath = [ "$HOME/${goBin}" ];
        home.packages = with pkgs;[
          gopls
          goreleaser
          air
          jetbrains.goland
        ];
        programs = {
          go = {
            enable = true;
            package = pkgs.go;
            inherit goPath goBin;
          };
        };
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = {
        servers = [ "gopls" ];
        tsLanguages = [ "go" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          golang.go
        ];
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
