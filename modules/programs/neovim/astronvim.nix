{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
in
{
  home._ = mkIf cfg.enable {
    xdg.configFile.astroNvimV4Template = {
      source = ../../../files/nvim;
      target = "nvim";
      recursive = true;
    };
  };
}
