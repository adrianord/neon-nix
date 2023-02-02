{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.markdown;
in
{
  options = lib.neon.mkLanguageOptions config "markdown";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          marksman
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "marksman" ];
        tsLanguages = [ "markdown" "markdown_inline" ];
      };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
