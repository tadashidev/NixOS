{
  description = "https://tadashi.dev";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
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
        inputs.stylix.homeModules.stylix
        inputs.niri-flake.homeModules.niri
        ./home.nix
      ];
    };
  };
}
