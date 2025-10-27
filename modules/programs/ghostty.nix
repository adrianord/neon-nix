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
              theme = Catppuccin Mocha
              window-save-state = never
              window-padding-y = 0
              quit-after-last-window-closed = true
              font-family = "${config.neon.common.font.default}"
              font-size = ${toString config.neon.common.font.size}
              font-feature = -calt
              font-feature = -liga
              font-feature = -dlig

              desktop-notifications = true

              keybind = super+physical:one=unbind
              keybind = super+ctrl+physical:one=unbind
              keybind = super+enter=unbind

              keybind = shift+enter=text:\n

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

              keybind = super+1=unbind
              keybind = super+2=unbind
              keybind = super+3=unbind
              keybind = super+4=unbind
              keybind = super+5=unbind
              keybind = super+6=unbind
              keybind = super+7=unbind
              keybind = super+8=unbind
              keybind = super+9=unbind
              keybind = super+0=unbind

              keybind = ctrl+t>physical:one=goto_tab:1
              keybind = ctrl+t>physical:two=goto_tab:2
              keybind = ctrl+t>physical:three=goto_tab:3
              keybind = ctrl+t>physical:four=goto_tab:4
              keybind = ctrl+t>physical:five=goto_tab:5
              keybind = ctrl+t>physical:six=goto_tab:6
              keybind = ctrl+t>physical:seven=goto_tab:7
              keybind = ctrl+t>physical:eight=goto_tab:8
              keybind = ctrl+t>physical:nine=goto_tab:9
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
