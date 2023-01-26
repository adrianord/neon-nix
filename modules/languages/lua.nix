{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.lua;
in
{
  options = lib.neon.language.mkOptions "lua";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      servers = [ "sumneko_lua" ];
      tsLanguages = [ "lua" ];
    };

    home._ = {
      home.packages = with pkgs; [
        sumneko-lua-language-server
      ];

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          sumneko.lua
        ];
      };
    };
  };
}
