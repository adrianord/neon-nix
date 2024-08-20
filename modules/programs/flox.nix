{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.neon.programs.flox;
in
{
  options = {
    neon.programs.flox = {
      enable = mkEnableOption "Enable flox";
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = [
        inputs.flox.packages.${pkgs.system}.default
      ];
    };
    nix.settings = {
      substituters = [
        "https://cache.flox.dev"
      ];
      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
      ];
    };
  };
}
