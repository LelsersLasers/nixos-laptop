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

    programs.helix = import ./helix/config.nix;
    programs.alacritty = import ./alacritty/config.nix;

    programs.git = {
      enable = true;
      userName = "LelsersLasers";
      userEmail = "millankumar@gmail.com";
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };



    home.stateVersion = "25.05";

    programs.home-manager.enable = true;
  }; 
}

