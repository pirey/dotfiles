# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "thinkpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pirey = {
    isNormalUser = true;
    description = "Yeri";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  # Enable sound with pipewire.
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    firefox
    unzip
    papirus-icon-theme
    nordic
    nordzy-cursor-theme
    file

    # xfce.thunar-archive-plugin
    # xarchiver

    gnomeExtensions.appindicator
    gnome.gnome-tweaks
  ];

  # Touchpad gesture
  services.touchegg.enable = true;

  # Key mapping daemon
  services.keyd.enable = true;
  services.keyd.settings = {
    main = {
      capslock = "overload(control, esc)";
      esc = "capslock";
    };
  };

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # GUI
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput.touchpad.tappingDragLock = false;
  };

  # XFCE
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.displayManager.lightdm = {
  #   enable = true;
  #   background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
  #   greeters.gtk = with pkgs; {
  #     clock-format = null;
  #     cursorTheme = {
  #       name = "Nordzy-white-cursors";
  #       package = nordzy-cursor-theme;
  #       size = 16;
  #     };
  #     enable = true;
  #     iconTheme = {
  #       name = "Nordic-Polar-standard-buttons";
  #       package = nordic;
  #     };
  #     indicators = null;
  #     theme = {
  #       name = "Nordic-Polar-standard-buttons";
  #       package = nordic;
  #     };
  #   };
  # };

  # GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.gnome.excludePackages = (with pkgs; [
      # gnome-photos
      gnome-tour
  ]) ++ (with pkgs.gnome; [
    # cheese # webcam tool
    # gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    # totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # KDE
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  #   # elisa
  #   # gwenview
  #   # okular
  #   oxygen
  #   khelpcenter
  #   konsole
  #   plasma-browser-integration
  #   # print-manager
  # ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  virtualisation.docker.enable = true;
}
