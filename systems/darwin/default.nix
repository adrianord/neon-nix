{ bootstrap }:
{
  gon = bootstrap (import ./gon.nix);
  rah = bootstrap (import ./rah.nix);
}
