{ config, lib, pkgs, ... }:

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

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        xdg.configFile = {
          ghosttyConfig = {
            text = ''
              theme = catppuccin-mocha
              window-save-state = never
              window-padding-y = 0
              quit-after-last-window-closed = true
              font-family = "${config.neon.common.font.default}"
              font-size = ${toString config.neon.common.font.size}
              font-feature = -calt
              font-feature = -liga
              font-feature = -dlig

              keybind = super+physical:one=unbind
              keybind = super+ctrl+physical:one=unbind
              keybind = super+enter=unbind

              keybind = ctrl+physical:one=unbind
              keybind = ctrl+physical:two=unbind
              keybind = ctrl+physical:three=unbind
              keybind = ctrl+physical:four=unbind
              keybind = ctrl+physical:five=unbind
              keybind = ctrl+physical:six=unbind
              keybind = ctrl+physical:seven=unbind
              keybind = ctrl+physical:eight=unbind
              keybind = ctrl+physical:nine=unbind
              keybind = ctrl+physical:zero=unbind

              keybind = super+physical:one=unbind
              keybind = super+physical:two=unbind
              keybind = super+physical:three=unbind
              keybind = super+physical:four=unbind
              keybind = super+physical:five=unbind
              keybind = super+physical:six=unbind
              keybind = super+physical:seven=unbind
              keybind = super+physical:eight=unbind
              keybind = super+physical:nine=unbind
              keybind = super+physical:zero=unbind
            '';
            target = "ghostty/config";
          };
        };
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [ "ghostty" ];
      };
    })
  ]);
}
