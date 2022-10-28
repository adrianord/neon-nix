nixpkgsLib:

let
  mkLib = import ./.;
in
nixpkgsLib.extends (self: super: {
  neon = mkLib { lib = self; };
})
