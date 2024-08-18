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
          pyright
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
              owner = "adrianord";
              repo = "zsh-activate-py-environment";
              rev = "55cb0dc6651c3c6534552c546d3ced0a1ff6096b";
              sha256 = "sha256-wC6vJRahshHiXlQ2x63alJ17rCzVyGMtSEHs0vOV4+I=";
            };
          }
        ];
      };
    })
  ]);
}
