{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.toml;
in
{
  options = lib.neon.language.mkOptions "toml";

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
          vscode-extensions.bungcip.better-toml
        ];
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
