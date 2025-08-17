{
  description = "https://tadashi.dev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs"; # TODO: Pin on new version of Nixpkgs.
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations."Aqua" = nixpkgs.lib.nixosSystem {
      modules = [
        inputs.niri-flake.nixosModules.niri
        ./hosts/aqua.nix
        ./configuration
      ];
      specialArgs = {nixpkgs = nixpkgs;};
    };
  };
}
