{ config, pkgs, ... }:

{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-backup";

  home-manager.users."millankumar" = {
    home.username = "millankumar";
    home.homeDirectory = "/home/millankumar";

    programs.bash = {
      enable = true;
      shellAliases = {
        ls = "eza -al";
        snrsfi = "sudo nixos-rebuild switch --flake . --impure";
      };
    };

    home.stateVersion = "25.05";

    programs.home-manager.enable = true;
  }; 
}

