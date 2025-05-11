{ pkgs, ... }:

{
  imports = [
    ./errorlens.nix
  ];

  home._.programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      streetsidesoftware.code-spell-checker
      pkief.material-icon-theme
      gruntfuggly.todo-tree
      ms-vscode-remote.remote-ssh
      christian-kohler.path-intellisense
      eamodio.gitlens
      editorconfig.editorconfig
      hbenl.vscode-test-explorer
      ms-vscode.test-adapter-converter
      ms-azuretools.vscode-docker
      github.copilot
    ];
    userSettings = {
      workbench = {
        colorTheme = "Catppuccin Mocha";
        iconTheme = "material-icon-theme";
      };
    };
  };
}
