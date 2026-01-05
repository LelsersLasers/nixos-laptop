{ config, pkgs, ... }:

{
    home.username = "millankumar";
    home.homeDirectory = "/home/millankumar";

    # COSMIC
    home.file.".config/cosmic/".source = ./cosmic;

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
        settings.user = {
            name = "LelsersLasers";
            email = "millankumar@gmail.com";
        };
    };
    programs.gh = {
        enable = true;
        gitCredentialHelper = {
        enable = true;
        };
    };


    home.stateVersion = "25.05";

    programs.home-manager.enable = true;
}

