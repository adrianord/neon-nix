{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.json;
in
{
  options = lib.neon.mkLanguageOptions config "json";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          nodePackages.vscode-langservers-extracted
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "jsonls" ];
        tsLanguages = [ "json" ];
      };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
