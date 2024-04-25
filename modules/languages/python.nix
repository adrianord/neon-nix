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
          poetry
          ruff
          ruff-lsp
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
        servers = [ "pyright" "ruff_lsp" ];
        tsLanguages = [ "python" ];
      };
    })

    (mkIf cfg.vscode.enable { })

    (mkIf cfg.zsh.enable {
      home._.programs.zsh = {
        plugins = [
          {
            name = "zsh-activate-py-environment";
            src = pkgs.fetchFromGitHub {
              owner = "se-jaeger";
              repo = "zsh-activate-py-environment";
              rev = "60f7d30b927d0d6e37ed8eeba9b788c319e1136e";
              sha256 = "sha256-kk2WIxUptWMRel3Ca+u5lhaHVU/svO5rF8NOiOfSrXA=";
            };
          }
        ];
      };
    })
  ]);
}
