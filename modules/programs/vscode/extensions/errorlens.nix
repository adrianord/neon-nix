{ pkgs, ... }:

{
  home._.programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
    ];

    userSettings.errorLens = {
      gutterIconsEnabled = true;
      excludeBySource = [ "cSpell" ];
    };
  };
}
