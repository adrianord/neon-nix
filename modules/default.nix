{ self, darwin, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:

{ host, user, modules ? [ ], additionalSpecialArgs ? { } }@userConf:
let
  lib = import ./lib/extend.nix nixpkgs.lib;
  host = {
    "linux" = {
      configurations = "nixosConfigurations";
      system = nixpkgs.lib.nixosSystem;
      modules = [
        home-manager.nixosModules.home-manager
      ];
    };
    "darwin" = {
      configurations = "darwinConfigurations";
      system = darwin.lib.darwinSystem;
      modules = [
        home-manager.darwinModules.home-manager
      ];
    };
  }.${userConf.host.os};
  system = userConf.host.arch + "-" + userConf.host.os;
  pkgs-stable = import nixpkgs-stable {
    inherit system;
    overlays = [
      (self: super: {
        nodejs = super.nodejs_22;
        nodejs-slim = super.nodejs-slim_22;
      })
    ];
  };
in
host.system {
  system = system;
  specialArgs = { inherit inputs userConf lib system pkgs-stable; } // additionalSpecialArgs;
  modules = host.modules ++
    [
      ./nix.nix
      ./common
      ./home.nix
      ./languages
      ./darwin.nix
      ./nixpkgs.nix
      ./programs
    ] ++ modules;
} 
