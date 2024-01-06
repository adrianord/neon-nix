{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  astroNvimRepo = fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
    ref = "main";
    rev = "271c9c3f71c2e315cb16c31276dec81ddca6a5a6";
  };
in
{
  home._ = mkIf cfg.enable {
    xdg.configFile.astroNvim = {
      source = astroNvimRepo;
      target = "nvim";
      recursive = true;
    };
    xdg.configFile.astroNvimUserFiles = {
      source = ./user;
      target = "nvim/lua/user";
      recursive = true;
    };
  };
}
