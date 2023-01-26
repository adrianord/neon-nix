{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.toml;
in
{
  options = lib.neon.language.mkOptions "toml";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      tsLanguages = [ "toml" ];
    };

    home._ = {
      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs; [
          vscode-extensions.bungcip.better-toml
        ];
      };
    };
  };
}
