{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.ghostty;
in
{
  options = {
    neon.programs.ghostty = {
      enable = mkEnableOption "Enable ghostty";
    };
  };

  config = mkIf cfg.enable {
    home._.xdg.configFile = {
      ghosttyConfig = {
        text = ''
          theme = catppuccin-mocha
          quit-after-last-window-closed = true
          font-family = "${config.neon.common.font.default}"
          font-size = ${toString config.neon.common.font.size}
          font-feature = -calt
          font-feature = -liga
          font-feature = -dlig

          keybind = super+physical:one=unbind
          keybind = super+ctrl+physical:one=unbind
          keybind = super+enter=unbind

          macos-titlebar-style = transparent
          window-save-state = never
        '';
        target = "ghostty/config";
      };
    };
  };
}
