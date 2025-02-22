{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  astroNvimRepo = fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
    ref = "main";
    rev = "1411df4d970e59f1b5721556a043c5c828daf5ad";
  };
in
{
  home._ = mkIf cfg.enable {
    xdg.configFile.astroNvim = {
      source = astroNvimRepo;
      target = "old_nvim";
      recursive = true;
    };
    xdg.configFile.astroNvimUserFiles = {
      source = ./user;
      target = "old_nvim/lua/user";
      recursive = true;
    };

    xdg.configFile.astroNvimV4Template = {
      source = ../../../files/nvim;
      target = "nvim";
      recursive = true;
    };
  };
}
