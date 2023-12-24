{
  description = "My System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    nix-index-database,
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
            nix-index-database.hmModules.nix-index
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          dotfiles = "/home/shaun/dotfiles";
        };
      };
    };
  };
}


