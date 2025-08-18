{
  description = "https://tadashi.dev";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs"; # TODO: Pin to stable.
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.tadashi = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        inputs.nix-index-database.homeModules.nix-index
        inputs.niri-flake.homeModules.niri
        inputs.stylix.homeModules.stylix

        ./home.nix
      ];
    };
  };
}
