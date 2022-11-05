{ pkgs, ... }:

let
  config = builtins.readFile ./configuration.lua;
in
{
  home._ = {
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
        ${config}
        EOF
      '';
    };
  };
}
