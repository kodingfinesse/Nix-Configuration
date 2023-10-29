# users/ana/default.nix
{ ... }:

{
  config = {
    home-manager.users.ana = ./home.nix;
    users.users.ana = {
      # ...
    };
  };
}
