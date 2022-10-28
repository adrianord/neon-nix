{ lib }:
with lib;
{
  mkOptions = name: {
    neon.languages.${name} = {
      enable = mkEnableOption name;
      enableVscodeIntegration = mkEnableOption "${name} vscode integration";
      enableVimIntegration = mkEnableOption "${name} vscode integration";
      enableZshIntegration = mkEnableOption "${name} zsh integration";
    };
  };
  enableLanguages =
    languages: builtins.foldl' (acc: curr: acc // curr) { }
      (map
        (x: {
          ${x} = {
            enable = true;
            enableVscodeIntegration = true;
            enableVimIntegration = true;
            enableZshIntegration = true;
          };
        })
        languages);
}
