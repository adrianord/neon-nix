{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
in
{
  options = {
    neon.programs.neovim = {
      enable = mkEnableOption "Enable direnv and nix-direnv";
    };
  };
  imports = [
    ./astronvim.nix
    ./lsp.nix
  ];
  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          ripgrep
          lazygit
          bottom
          tree-sitter
        ];
        home.sessionVariables = {
          EDITOR = "vim";
        };
        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
        };
      };
    })
    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew.casks = mkIf pkgs.stdenv.hostPlatform.isDarwin [
        "neovide"
      ];
    })
  ]);
}
