{
  description = "TDENKOV system config";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      hostName = "nixxx";
      user = "tdenkov";
    in {

    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        pkgs-stable = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit inputs system homeStateVersion hostName user;
      };
      modules = [
        ./configuration.nix
        stylix.nixosModules.stylix
      ];
    };

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit user hostName homeStateVersion system inputs;
      };
      modules = [ ./home-manager/home.nix ];
    };
  };
}