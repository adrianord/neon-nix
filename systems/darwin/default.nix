{ bootstrap }:
{
  gon = bootstrap (import ./gon.nix);
  rah = bootstrap (import ./rah.nix);
  highlight = bootstrap (import ./rah.nix);
  fanatics = bootstrap (import ./fanatics.nix);
}
