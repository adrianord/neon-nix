{ config, lib, pkgs, inputs, ... }:

with lib;
let
  utils = builtins.readFile ./utils.lua;
  cfg = config.neon.programs.neovim;
in
{
  options = {
    neon.programs.neovim = {
      enable = mkEnableOption "Enable direnv and nix-direnv";
      configure = mkEnableOption "Configure neovim using neon-nix";
    };
  };
  imports = [
    ./options
    ./appearance
    ./plugins
  ];
  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
        ];
        home.packages = with pkgs; [
          ripgrep
          lazygit
          bottom
        ];
        home.sessionVariables = {
          EDITOR = "vim";
        };
        programs.nixvim = {};
        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          extraConfig = mkIf cfg.configure ''
            lua << EOF
            ${utils}
            EOF
          '';
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
