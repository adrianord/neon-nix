{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  luaConfig = builtins.readFile ./options.lua;
in
{
  home._.programs.neovim.extraConfig = mkIf cfg.configure ''
    lua << EOF
    ${luaConfig}
    EOF
  '';
}
