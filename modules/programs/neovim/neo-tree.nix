{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
in
{
  config = mkIf cfg.enable {
    home._.xdg.configFile = {
      astroNvimUserNeoTree = {
        text = ''
          return { 
            window = {
              position = "right", 
              width = 50,
            },
          }
        '';
        target = "nvim/lua/user/plugins/neo-tree.lua";
      };
    };
  };
}
