{ lib, options, userConf, config, ... }:

with lib;
{
  options = with types; {
    home = {
      _ = mkOption {
        type = attrs;
        default = { };
        description = "For passing arbitrary configuration to user's home-manager config";
      };
      config = mkOption {
        type = attrs;
        default = config.home-manager.users.${userConf.user.name};
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
