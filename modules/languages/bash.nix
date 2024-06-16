{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.bash;
in
{
  options = lib.neon.mkLanguageOptions config "bash";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          bash-language-server
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "bashls" ];
        tsLanguages = [ "bash" ];
      };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
