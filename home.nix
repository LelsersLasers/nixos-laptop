{ config, pkgs, ... }:

{
    home.username = "millankumar";
    home.homeDirectory = "/home/millankumar";

    home.file.".config/background/".source = ./background;

    home.file.".config/starship.toml".source = ./starship/starship.toml;

    # hypr
    home.file.".config/hypr/".source = ./hypr;
    home.file.".config/waybar/".source = ./waybar;
    home.file.".config/wofi/".source = ./wofi;
    home.file.".config/wlogout/".source = ./wlogout;

    programs.bash = {
        enable = true;
        shellAliases = {
            ls = "eza -al";
            snrsfi = "sudo nixos-rebuild switch --flake . --impure";
        };
        bashrcExtra = ''
            # Starship prompt
            eval "$(starship init bash)"
        '';
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

