{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.python;
in
{
  options = lib.neon.language.mkOptions "python";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      servers = [ "pyright" ];
      tsLanguages = [ "python" ];
    };

    home._ = {
      home.packages = with pkgs; [
        nodePackages.pyright
        (python3.withPackages
          (p: with p; [
            setuptools
            pip
          ]))
      ];
    };
  };
}
