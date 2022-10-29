nixpkgsLib:

let
  mkLib = import ./.;
in
nixpkgsLib.extend (self: super: {
  neon = mkLib { lib = self; };
})
