{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  astroNvimRepo = fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
    ref = "main";
    rev = "e341895375a7994c90085e837b0384f3071f6463";
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
