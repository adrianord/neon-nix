{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nix;
in
{
  options = lib.neon.language.mkOptions "nix";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          nixpkgs-fmt
          nil
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "nil_ls" ];
        tsLanguages = [ "nix" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs; [
          vscode-extensions.bbenoist.nix
          vscode-extensions.jnoortheen.nix-ide
        ];
        userSettings.nix = {
          enableLanguageServer = true;
          serverPath = "nil";
        };
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
