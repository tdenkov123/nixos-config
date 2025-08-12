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

      mkHost = hostName: extraModules: nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system homeStateVersion hostName user unstablePkgs;
        };
        modules = [
          ./configuration.nix
          stylix.nixosModules.stylix
        ] ++ extraModules;
      };
    in {

    # VM host
    nixosConfigurations.nixxx = mkHost "nixxx" [ ./devices/vm.nix ];

    # PC host
    nixosConfigurations.desktop = mkHost "desktop" [ ./devices/pc.nix ];

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit user hostName homeStateVersion system inputs unstablePkgs;
      };
      modules = [ ./home-manager/home.nix ];
    };
  };
}