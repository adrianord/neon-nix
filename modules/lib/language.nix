{ lib }:
with lib;
{
  mkOptions = name: {
    neon.languages.${name} = {
      enable = mkEnableOption name;
      neovim = {
        enable = mkEnableOption "${name} neovim integration";
      };
      vscode = {
        enable = mkEnableOption "${name} vscode integration";
      };
      zsh = {
        enable = mkEnableOption "${name} zsh integration";
      };
    };
  };

  enableLanguages =
    { vscode ? false
    , neovim ? false
    , zsh ? false
    , languages
    }:
    builtins.foldl' (acc: curr: acc // curr) { }
      (map
        (x: {
          ${x} = {
            enable = true;
            neovim = {
              enable = neovim;
            };
            vscode = {
              enable = vscode;
            };
            zsh = {
              enable = zsh;
            };
          };
        })
        languages);
}
