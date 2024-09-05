{
  description = "Neon Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    firefox-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vscodeInsiders.url = "github:cideM/visual-studio-code-insiders-nix";

    nur.url = "github:nix-community/NUR";

    rust-overlay = { url = "github:oxalica/rust-overlay"; };
    rust-overlay .inputs.nixpkgs.follows = "nixpkgs";

    flox.url = "github:flox/flox/v1.2.3";
  };

  outputs = inputs:
    let
      bootstrap = import ./modules inputs;
    in
    {
      default = bootstrap;
      darwinConfigurations = import ./systems/darwin { inherit bootstrap; };
    };
}
