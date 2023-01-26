{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
in
{
  config = mkIf cfg.enable {
    home._.xdg.configFile = {
      astroNvimUserSessionManager = {
        text = ''
          return { 
            event = "VimEnter",
            autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
          }
        '';
        target = "nvim/lua/user/plugins/session_manager.lua";
      };
    };
  };
}
