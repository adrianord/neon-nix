{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.python;
in
{
  options = lib.neon.mkLanguageOptions config "python";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          nodePackages.pyright
          (python3.withPackages
            (p: with p; [
              setuptools
              pip
            ]))
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "pyright" ];
        tsLanguages = [ "python" ];
      };
    })

    (mkIf cfg.vscode.enable { })

    (mkIf cfg.zsh.enable { })
  ]);
}
