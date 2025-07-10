{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with PipeWire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account.
  users.users.benjamin = {
    isNormalUser = true;
    description = "Benjamin";
    extraGroups = [ "networkmanager" "wheel" "docker" ]; # Added "docker" group for Docker access
    packages = with pkgs; [
      # thunderbird
    ];
  };

  # Install Firefox.
  programs.firefox.enable = true;

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Setting to enable Nixflakes per the wiki -
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # Utilities
    adoptopenjdk-icedtea-web
    audacity
    calibre
    cutecom
    fastfetch
    # flameshot - Commented out since there is an error with the GUI
    git
    gnome.gnome-screenshot
    gparted
    htop
    handbrake
    img2pdf
    ipmitool
    localsend
    nmap
    #qbittorrent
    qemu
    tldr
    tmux
    tor-browser
    unzip
    # virtualbox - commented out since there is an error - https://github.com/NixOS/nixpkgs/issues/76108#issuecomment-592195955
    vscode
    waydroid
    wireshark
    obsidian
    ollama
    remmina
    powershell

    # Gaming
    lutris
    steam
    pcsx2
    dolphin-emu
    prismlauncher

    # Themes
    gnome-extension-manager
    gnome.gnome-tweaks
    nordic
    numix-icon-theme-circle
    
    # Social
    signal-desktop
  ];

  # Fonts.
  fonts.packages = with pkgs; [
    comic-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    roboto-mono
  ];

  # Enable virtualization for VirtualBox.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "benjamin" ];

  # Enable guest additions for VirtualBox.
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.draganddrop = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  
  # Enable/install Tailscale client
  services.tailscale.enable = true;

  # Set system state version.
  system.stateVersion = "24.05";

  # Steam configuration.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # iGPU hardware acceleration for OpenGL.
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      onevpl-intel-gpu  # For newer GPUs on NixOS <= 24.05
    ];
  };
}
