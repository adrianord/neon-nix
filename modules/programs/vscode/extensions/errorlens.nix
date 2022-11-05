{ pkgs, ... }:

{
  home._.programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      usernamehw.errorlens
    ];

    userSettings.errorLens = {
      gutterIconsEnabled = true;
      excludeBySource = [ "cSpell" ];
    };
  };
}
