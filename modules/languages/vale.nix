{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.vale;
in
{
  options = lib.neon.language.mkOptions "vale";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        vale
      ];
    };
  };
}
