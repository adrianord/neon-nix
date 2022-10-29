{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nix;
in
{
  options = lib.neon.language.mkOptions "nix";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        nixpkgs-fmt
        rnix-lsp
        nil
      ];
      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs; [
          vscode-extensions.bbenoist.nix
          vscode-extensions.jnoortheen.nix-ide
        ];
        userSettings.nix = {
          enableLanguageServer = true;
          serverPath = "nil";
        };
      };
    };
  };
}
