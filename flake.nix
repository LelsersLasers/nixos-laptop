{
  description = "Personal NixOS laptop configuration";

  inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

     home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel-fork = {
      url = "github:LelsersLasers/HyprPanel/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, helix-master, home-manager, antigravity-nix, hyprpanel-fork, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      helix = helix-master.packages.${system}.helix;
      antigravity-pkgs = antigravity-nix.packages.${system};
      hyprpanel = hyprpanel-fork.packages.${system}.hyprpanel;
    in {
      nixosConfigurations.envy-millan = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            _module.args.helix = helix;
            _module.args.antigravity-pkgs = antigravity-pkgs;
            _module.args.hyprpanel = hyprpanel;
          }
          home-manager.nixosModules.home-manager
        ];
      };
  };
}
