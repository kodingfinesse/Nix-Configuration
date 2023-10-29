# users/ana/home.nix
{ ... }:

{
  home.username = "ana";
  home.homeDirectory = "/home/ana";
  # ...
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
