{ self, darwin, nixpkgs, home-manager, inputs, ... }:

{ host, user, configModule, additionalModules ? [ ], additionalSpecialArgs ? { } }@userConf:
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
in
{
  configuration = host.system {
    system = userConf.host.arch + "-" + userConf.host.os;
    specialArgs = { inherit inputs userConf lib; } // additionalSpecialArgs;
    modules = host.modules ++ [
      {
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';
      }
      configModule
    ] ++
      [
        ./common
        ./home.nix
        ./languages
        ./darwin.nix
        ./nixpkgs.nix
        ./programs
      ] ++ additionalModules;
  };
} 
