{ config, pkgs, helix, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader
  # BIOS
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;
  # EFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;


  # Hostname
  networking.hostName = "envy-millan";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Suspend settings
  services.logind.settings = {
    Login = {
      # Suspend after 15 min idle
      IdleAction = "suspend";
      IdleActionSec = 900;
    
      # Lid behavior (suspend on battery, ignore on AC)
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "suspend";
    };
  };

  # Laptop
  # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
  # services.thermald.enable = true;
  # services.tlp = {
  #     enable = true;
  #     settings = {
  #       CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #       CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #       CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

  #       CPU_MIN_PERF_ON_AC = 0;
  #       CPU_MAX_PERF_ON_AC = 100;
  #       CPU_MIN_PERF_ON_BAT = 0;
  #       CPU_MAX_PERF_ON_BAT = 80;

  #      # Optional helps save long term battery health
  #      START_CHARGE_THRESH_BAT0 = 75; # 75 and below it starts to charge
  #      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
  #     };
  # };
  # # GNOME may try to enable power-profiles-daemon which conflicts with tlp
  # services.power-profiles-daemon.enable = false;

  # Caps lock = escape key
  services.xserver.xkb.options = "caps:escape";

  # VMware only
  # virtualisation.vmware.guest.enable = true;
  # services.xserver.videoDrivers = [ "vmware" ];

  # Automatic clean up
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +3";  # Keep last 3 generations, delete older
  };
  nix.settings.auto-optimise-store = true;

  # Enable networking
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "America/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # nix-ld
  programs.nix-ld.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the GNOME Plasma Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-os-services.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    epiphany
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    simple-scan
    gnome-connections
    yelp
  ];

  # Enable COSMIC desktop environment
  # services.desktopManager.cosmic.enable = true;

  # Enable hyprland
  programs.hyprland.enable = true;
  # programs.waybar.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  # Allow ozone wayland backend
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable flatpak
  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable SSH
  services.openssh.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.millankumar = {
    isNormalUser = true;
    description = "Millan Kumar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Home manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    users.millankumar = import ./home.nix;
  };

  # Grub theme, BIOS only
#   boot.loader.grub.theme = pkgs.fetchFromGitHub {
#     owner = "shvchk";
#     repo = "poly-light";
#     rev = "7386e13abfaa8bc59524c02b4e027bac2872e908";
#     sha256 = "sha256-sQqVv2QgS7mAISBT3oFSwWRmhUEyclzV89xpzHDt9JA=";
#   };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Other applications
  programs.starship.enable = true;
  programs.firefox.enable = true;
  programs.zoom-us.enable = true;

  environment.systemPackages = with pkgs; [
    # fonts
    nerd-fonts.caskaydia-mono

    # system
    pciutils

    # hypr
    hyprland
    hyprpaper
    hyprsunset
    hyprshot
    wofi
    # wlogout
    # swaynotificationcenter
    wireplumber
    playerctl
    hyprpolkitagent
    hyprpanel
    # pavucontrol
    # networkmanagerapplet
    nwg-look

    # CLI editors
    vim
    helix

    # Code tools
    git
    gh

    # CLI tools
    htop
    eza
    cmatrix

    # GUI apps
    google-chrome
    calibre
    discord
    slack
    libreoffice-fresh
    spotify

    # GUI tools
    alacritty
    github-desktop
    vscode.fhs
    arduino #v1
    arduino-ide #v2

    # Programming
    python3
    jdk
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
