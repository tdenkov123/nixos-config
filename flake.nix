{
  description = "TDENKOV system config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.11";
      user = "tdenkov";
      unstablePkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };

      mkHost = host: extraModules: nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          hostName = host;
          inherit inputs system homeStateVersion user unstablePkgs;
        };
        modules = [
          ./configuration.nix
        ] ++ extraModules;
      };
    in
    {

      # VM host
      nixosConfigurations.vm = mkHost "vm" [ ./devices/vm.nix ];

      # PC host
      nixosConfigurations.desktop = mkHost "desktop" [ ./devices/desktop.nix ];

      homeConfigurations = {
        "${user}@vm" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit user homeStateVersion system inputs unstablePkgs;
            hostName = "vm";
          };
          modules = [ ./home-manager/home.nix ];
        };
        "${user}@desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit user homeStateVersion system inputs unstablePkgs;
            hostName = "desktop";
          };
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
