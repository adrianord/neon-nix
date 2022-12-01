{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  luaConfig = builtins.readFile ./configuration.lua;
in
{
  home._ = mkIf cfg.configure {
    home.packages = with pkgs; [
      fzf
    ];
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        telescope-nvim
        telescope-fzf-native-nvim
      ];
      extraConfig = ''
        lua << EOF
        ${luaConfig}
        EOF
      '';
    };
  };
}
