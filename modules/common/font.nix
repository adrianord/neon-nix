{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.neon.common.font;
in
{
  options = {
    neon.common.font = with types; {
      packages = mkOption {
        description = "Font packages to install";
        type = listOf package;
        default = with pkgs; [
          jetbrains-mono
        ];
      };
      default = mkOption {
        description = "Default font to use for programs managed by neon";
        type = str;
        default = "JetBrainsMono Nerd Font";
      };
    };
  };
  
  config = {
    #fonts.fonts = cfg.packages;
  };
}