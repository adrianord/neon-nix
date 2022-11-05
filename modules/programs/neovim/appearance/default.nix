{ pkgs, ... }:

let
  config = builtins.readFile ./appearance.vim;
in
{
  home._.programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
    ];
    extraConfig = config;
  };
}
