{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.python;
in
{
  options = lib.neon.language.mkOptions "python";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        (python3.withPackages
          (p: with p; [
            setuptools
            pip
          ]))
      ];
    };
  };
}
