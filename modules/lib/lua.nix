{ lib }:

with lib;
rec {
  # taken from https://github.com/pta2002/nixvim/blob/8a0056617afbdef0a5dee89505e1e20c2798295f/lib/helpers.nix#L10
  # Black functional magic that converts a bunch of different Nix types to their
  # lua equivalents!
  toLuaObject = args:
    if builtins.isAttrs args then
      if hasAttr "__raw" args then
        args.__raw
      else
        "{" + (concatStringsSep ","
          (mapAttrsToList
            (n: v:
              if head (stringToCharacters n) == "@" then
                toLuaObject v
              else "[${toLuaObject n}] = " + (toLuaObject v))
            (filterAttrs (n: v: !isNull v && toLuaObject v != "{}") args))) + "}"
    else if builtins.isList args then
      "{" + concatMapStringsSep "," toLuaObject args + "}"
    else if builtins.isString args then
    # This should be enough!
      builtins.toJSON args
    else if builtins.isPath args then
      builtins.toJSON (toString args)
    else if builtins.isBool args then
      "${ boolToString args }"
    else if builtins.isFloat args then
      "${ toString args }"
    else if builtins.isInt args then
      "${ toString args }"
    else if isNull args then
      "nil"
    else "";
}
