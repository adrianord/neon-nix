{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nix;
in
{
  options = lib.neon.mkLanguageOptions config "nix";

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
        serverSettings.nil_ls = {
          settings.nil.formatting.command = [ "nixpkgs-fmt" ];
        };
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
