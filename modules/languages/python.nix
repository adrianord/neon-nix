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
          uv
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
        servers = [ "ruff" ];
        tsLanguages = [ "python" ];
        masonServers = [ "pyright" ];
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
              rev = "06e47a93573b8094c3d204b56b52eb85d03d4363";
              sha256 = "sha256-Kif/40fhdSLAv3U7yMdgzZ09arFDfqVSGmweNcAZdII=";
            };
          }
        ];
      };
    })
  ]);
}
