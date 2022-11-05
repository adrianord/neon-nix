{ ... }:

let
  config = builtins.readFile ./options.lua;
in
{
  home._.programs.neovim.extraConfig = ''
    lua << EOF
    ${config}
    EOF
  '';
}
