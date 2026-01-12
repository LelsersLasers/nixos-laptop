{ config, pkgs, ... }:

{
    home.username = "millankumar";
    home.homeDirectory = "/home/millankumar";

    home.file.".config/background/".source = ./background;

    home.file.".local/share/icons/BreezeX-Dark/".source = ./themes/BreezeX-Dark;
    home.file.".local/share/icons/Papirus-Dark/".source = ./themes/Papirus-Dark;
    home.file.".local/share/themes/Catppuccin-Macchiato-Standard-Green-Dark/".source = ./themes/Catppuccin-Macchiato-Standard-Green-Dark;

    home.file.".config/starship.toml".source = ./starship/starship.toml;

    # hypr
    home.file.".config/hypr/".source = ./hypr;
    # home.file.".config/waybar/".source = ./waybar;
    home.file.".config/wofi/".source = ./wofi;
    # home.file.".config/wlogout/".source = ./wlogout;
    # The line below should work, but there is no reason to make it read only while I am still playing with the config
    # home.file.".config/hyprpanel/config.json".source = ./hyprpanel/config.json;

    # Default apps
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "x-scheme-handler/http"  = [ "google-chrome.desktop" ];
            "x-scheme-handler/https" = [ "google-chrome.desktop" ];
            "text/html"              = [ "google-chrome.desktop" ];
            "application/pdf"        = [ "org.gnome.Papers.desktop" ];
        };
    };


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

