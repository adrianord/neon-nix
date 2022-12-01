{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.java;
in
{
  options = lib.neon.language.mkOptions "java";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        jdk
      ];
    };
  };
}
