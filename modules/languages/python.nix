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
        servers = [ "pyright" "ruff" ];
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
              rev = "a3feb11e5b9c634c610073d4bd17d77a6b3a3224";
              sha256 = "sha256-APUHmeulNHPe+SbLcb+1ZD5bMGVqMvl13lvu5byQZFg=";
            };
          }
        ];
      };
    })
  ]);
}
