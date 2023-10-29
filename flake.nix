{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ...
  };
  outputs = { self, nixpkgs, home-manager }:
    let
      # ...
    in {
      # ...
      nixosModules = {
        users-ana = ./users/ana;
        declarativeHome = { ... }: {
          config = {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          };
        };
        nixosConfigurations = {
        gizmo = {
          system = "aarch64-linux";
          modules = with self.nixosModules; [
            ({ config = { nix.registry.nixpkgs.flake = nixpkgs; }; })
            # ...
            home-manager.nixosModules.home-manager
            gnome
            declarativeHome
            users-ana
          ];
        };
        # ...
      }
        gnome = { pkgs, ... }: {
          config = {
            services.xserver.enable = true;
            services.xserver.displayManager.gdm.enable = true;
            services.xserver.desktopManager.gnome.enable = true;
            environment.gnome.excludePackages = (with pkgs; [
              gnome-photos
              gnome-tour
            ]) ++ (with pkgs.gnome; [
              cheese # webcam tool
              gnome-music
              gedit # text editor
              epiphany # web browser
              geary # email reader
              gnome-characters
              tali # poker game
              iagno # go game
              hitori # sudoku game
              atomix # puzzle game
              yelp # Help view
              gnome-contacts
              gnome-initial-setup
            ]);
            programs.dconf.enable = true;
            environment.systemPackages = with pkgs; [
              gnome.gnome-tweaks
            ]
          };
        };
      };
    };
}
