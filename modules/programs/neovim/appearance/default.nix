{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  vimConfig = builtins.readFile ./appearance.vim;
in
{
  home._.programs.neovim = mkIf cfg.configure {
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
    ];
    extraConfig = vimConfig;
  };
}
