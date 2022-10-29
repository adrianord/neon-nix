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
      version = "2.0.0";
      sha256 = "sha256-RRiPhRImztCWyCu+klDsmvNhF49V9BTVeAnoOJ+i7hY=";
    }
    #PKief.material-icon-theme
    {
      name = "material-icon-theme";
      publisher = "PKief";
      version = "4.20.0";
      sha256 = "sha256-OfFN//lnRPouREucEJKpKfXcyCN/nnZtH5oD23B4YX0=";
    }
    #Gruntfuggly.todo-tree
    {
      name = "todo-tree";
      publisher = "Gruntfuggly";
      version = "0.0.215";
      sha256 = "sha256-WK9J6TvmMCLoqeKWh5FVp1mNAXPWVmRvi/iFuLWMylM=";
    }
  ];

  extensionsListOfSet = map (x: { ${x.publisher}.${x.name} = pkgs.vscode-utils.extensionFromVscodeMarketplace x; }) extensionsList;
  extensionsSet = builtins.foldl' (acc: curr: acc // curr) { } extensionsListOfSet;
in
{
  vscode-extensions = super.vscode-extensions // extensionsSet;
}
