{ lib, options, userConf, ... }:

with lib;
{
  options = with types; {
    home = {
      _ = mkOption {
        type = attrs;
        default = { };
        description = "For passing arbitrrary configuration to user's home-manager config";
      };
    };
  };
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home._ = {
      home.stateVersion = "22.11";
    };
    home-manager.users.${userConf.user.name} = mkAliasDefinitions options.home._;
  };
}
