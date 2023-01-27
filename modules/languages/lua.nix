{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.lua;
in
{
  options = lib.neon.language.mkOptions "lua";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          sumneko-lua-language-server
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "sumneko_lua" ];
        tsLanguages = [ "lua" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          sumneko.lua
        ];
      };
    })


    (mkIf cfg.zsh.enable { })
  ]);
}
