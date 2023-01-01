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
      version = "2.5.0";
      sha256 = "sha256-+dM6MKIjzPdYoRe1DYJ08A+nHHlkTsm+I6CYmnmSRj4=";
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
    {
      name = "vscode-test-explorer";
      publisher = "hbenl";
      version = "2.21.1";
      sha256 = "sha256-fHyePd8fYPt7zPHBGiVmd8fRx+IM3/cSBCyiI/C0VAg=";
    }
    {
      name = "test-adapter-converter";
      publisher = "ms-vscode";
      version = "0.1.6";
      sha256 = "sha256-UC8tUe+JJ3r8nb9SsPlvVXw74W75JWjMifk39JClRF4=";
    }
  ];

  extensionsListOfSet = map (x: { ${x.publisher}.${x.name} = pkgs.vscode-utils.extensionFromVscodeMarketplace x; }) extensionsList;
  extensionsSet = builtins.foldl' (acc: curr: self.lib.recursiveUpdate acc curr) { } extensionsListOfSet;
in
{
  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions extensionsSet;
}
