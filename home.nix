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


    programs.helix = {
      enable = true;
      # Main Helix settings ( config.toml)
      settings = {
        theme = "rose_pine_moon_trans";
        editor = {
          true-color = true;
          cursorline = true;
          auto-format = false;
          idle-timeout = 0;
          completion-trigger-len = 1;
          end-of-line-diagnostics = "hint";
          rulers = [80];
          bufferline = "always";

          statusline = {
            left = ["mode" "spinner" "version-control"];
            center = ["file-name" "read-only-indicator" "file-modification-indicator"];
            right = [
              "diagnostics" "selections" "register"
              "position" "position-percentage"
              "file-encoding" "file-type"
            ];
            separator = "|";
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };

          lsp.display-messages = true;

          indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 1;
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          soft-wrap.enable = true;

          inline-diagnostics = {
            cursor-line = "hint";
            other-lines = "warning";
          };
        };
        keys = {
          normal = {
            "C-q" = ":buffer-close";
            "C-j" = ["move_visual_line_down" "scroll_down"];
            "C-k" = ["move_visual_line_up" "scroll_up"];

            " " = {
              "S-e" = "file_explorer";
              "e" = "file_explorer_in_current_buffer_directory";
            };
          };
        };
      };
      # Language configuration (languages.toml)
      languages = {
        language = [
          {
            name = "java";
            indent = { tab-width = 4; unit = " "; };
          }
          {
            name = "python";
            language-servers = [ { name = "python-lsp"; } ];
          }
          {
            name = "c";
            indent = { tab-width = 2; unit = "  "; };
          }
        ];
        language-server = {
          python-lsp = {
            command = "pyright-langserver";
            args = ["--stdio"];
            config = "";
          };
        };
      };
      # Custom themes
      themes.rose_pine_moon_trans = {
        inherits = "rose_pine_moon";
        ui.background = { };
      };
    };

    home.stateVersion = "25.05";

    programs.home-manager.enable = true;
  }; 
}

