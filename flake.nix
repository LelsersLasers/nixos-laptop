{
  description = "Personal NixOS laptop configuration";

  inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

     home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, helix-master, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      helix = helix-master.packages.${system}.helix;
    in {
      nixosConfigurations.envy-millan = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          { _module.args.helix = helix; }
          home-manager.nixosModules.home-manager
        ];
      };
  };
}
