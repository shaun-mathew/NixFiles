{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          };
      };
    pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          };
    };
  in {
    homeConfigurations = {
      shaun = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./hosts/shaun/home.nix
        ];
        extraSpecialArgs = {
	  inherit pkgs-unstable;
	  dotfiles = "/home/shaun/dotfiles";
        };
      };
    };
  };
}


