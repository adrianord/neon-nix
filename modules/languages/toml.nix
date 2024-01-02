{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.toml;
in
{
  options = lib.neon.mkLanguageOptions config "toml";

  config = mkIf cfg.enable (mkMerge [
    ({ })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        tsLanguages = [ "toml" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs; [
          vscode-extensions.tamasfe.even-better-toml
        ];
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
