self: super:
with self;
let
  extensionsList = [
    {
      name = "theme-monokai-pro-vscode";
      publisher = "monokai";
      version = "1.1.21";
      sha256 = "sha256-ZFIILLY88b25QuJBlAPWIFqbA+c/sxdfaDc1Mbyy/5o=";
    }
    {
      name = "vscode-typescript-next";
      publisher = "ms-vscode";
      version = "4.9.20220907";
      sha256 = "sha256-yBbHwk8xO742yQoNYkgxYvwgPCbSlPsjceDz8apMJ7o=";
    }
    {
      name = "vs-code-prettier-eslint";
      publisher = "rvest";
      version = "5.0.4";
      sha256 = "sha256-aLEAuFQQTxyFSfr7dXaYpm11UyBuDwBNa0SBCMJAVRI=";
    }
    {
      name = "catppuccin-vsc";
      publisher = "Catppuccin";
      version = "2.4.0";
      sha256 = "sha256-5S6XrdAJwnsy7JO62e4yvcKDJhOjxbnqaQbQuXlrZE0=";
    }
    {
      name = "material-icon-theme";
      publisher = "PKief";
      version = "4.20.0";
      sha256 = "sha256-OfFN//lnRPouREucEJKpKfXcyCN/nnZtH5oD23B4YX0=";
    }
    {
      name = "todo-tree";
      publisher = "Gruntfuggly";
      version = "0.0.220";
      sha256 = "sha256-U7aY2/ESz9f8foBjydy1G/bWd7CLNyIjDWE3pytZfxo=";
    }
    {
      name = "vscode-codeql";
      publisher = "GitHub";
      version = "1.7.6";
      sha256 = "sha256-0nD0bWmXHIwKMwOvH57yk8a28heA7HGCtoaeIbHXfg4=";
    }
  ];

  extensionsListOfSet = map (x: { ${x.publisher}.${x.name} = pkgs.vscode-utils.extensionFromVscodeMarketplace x; }) extensionsList;
  extensionsSet = builtins.foldl' (acc: curr: acc // curr) { } extensionsListOfSet;
in
{
  vscode-extensions = super.vscode-extensions // extensionsSet;
}
