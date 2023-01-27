{ lib }:
with lib;
{
  mkLanguageOptions = config: name: {
    neon.languages.${name} = {
      enable = mkEnableOption name;
      neovim = {
        enable = mkEnableOption "${name} neovim integration" // {
          default = config.neon.programs.neovim.enable;
        };
      };
      vscode = {
        enable = mkEnableOption "${name} vscode integration" // {
          default = config.neon.programs.vscode.enable;
        };
      };
      zsh = {
        enable = mkEnableOption "${name} zsh integration" // {
          default = config.neon.programs.zsh.enable;
        };
      };
    };
  };

  enableLanguages = languages:
    builtins.foldl' (acc: curr: acc // curr) { }
      (map
        (x: {
          ${x}.enable = true;
        })
        languages);
}
