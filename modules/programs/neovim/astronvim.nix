{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  astroNvimRepo = fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
    ref = "main";
    rev = "59d657c223038359b2b5e230805abca8d919280d";
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
