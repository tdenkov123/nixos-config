{
  description = "TDENKOV system config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      user = "tdenkov";
      hostName = "nixxx";
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
          stylix.nixosModules.stylix
        ] ++ extraModules;
      };
    in {

    # VM host
    nixosConfigurations.nixxx = mkHost "vm" [ ./devices/vm.nix ];

    # PC host
    nixosConfigurations.desktop = mkHost "desktop" [ ./devices/pc.nix ];

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