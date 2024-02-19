{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.just;
in
{
  options = lib.neon.mkLanguageOptions config "just";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          just
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable { };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
