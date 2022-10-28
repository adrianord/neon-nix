{
  description = "Neon Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vscodeInsiders.url = "github:cideM/visual-studio-code-insiders-nix";

    nur.url = "github:nix-community/NUR";

    rust-overlay = { url = "github:oxalica/rust-overlay"; };
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... }@inputs: {
    default = import ./modules { inherit self darwin nixpkgs home-manager inputs; };
  };
}
