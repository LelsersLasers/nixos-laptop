{
  description = "Personal NixOS laptop configuration";

  inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.envy-millan = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}
