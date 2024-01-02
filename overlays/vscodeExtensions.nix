self: super:
with self;
let
  extensionsList = [
    {
      name = "vscode-test-explorer";
      publisher = "hbenl";
      version = "2.21.1";
      sha256 = "sha256-fHyePd8fYPt7zPHBGiVmd8fRx+IM3/cSBCyiI/C0VAg=";
    }
    {
      name = "test-adapter-converter";
      publisher = "ms-vscode";
      version = "0.1.8";
      sha256 = "sha256-ybb3Wud6MSVWEup9yNN4Y4f5lJRCL3kyrGbxB8SphDs=";
    }
  ];

  extensionsListOfSet = map (x: { ${x.publisher}.${x.name} = pkgs.vscode-utils.extensionFromVscodeMarketplace x; }) extensionsList;
  extensionsSet = builtins.foldl' (acc: curr: self.lib.recursiveUpdate acc curr) { } extensionsListOfSet;
in
{
  vscode-extensions = self.lib.recursiveUpdate super.vscode-extensions extensionsSet;
}
