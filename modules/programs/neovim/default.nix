{ config, lib, pkgs, ... }:


with lib;
let
  utils = builtins.readFile ./utils.lua;
  cfg = config.neon.programs.neovim;
in
{
  options = {
    neon.programs.neovim = {
      enable = mkEnableOption "Enable direnv and nix-direnv";
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
        home.packages = with pkgs; [
          ripgrep
          lazygit
          bottom
        ];
        home.sessionVariables = {
          EDITOR = "vim";
        };
        programs.neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          extraConfig = ''
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
