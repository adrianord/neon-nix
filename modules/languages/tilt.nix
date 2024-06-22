{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.tilt;
in
{
  options = lib.neon.mkLanguageOptions config "tilt";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          tilt
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "tilt_ls" ];
      };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
