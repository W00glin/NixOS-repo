# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "New_Machine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.benjamin = {
    isNormalUser = true;
    description = "Benjamin";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    audacity
    calibre
    cutecom
    fastfetch
    gemini-cli
    gimp-with-plugins
    git
    gnome-screenshot        # FIXED: was gnome.gnome-screenshot
    gparted
    htop
    handbrake
    img2pdf
    ipmitool
    libreoffice
    llama-cpp
    localsend
    nmap
    qemu
    tailscale
    tldr
    tmux
    tor-browser
    unzip
    vscode
    waydroid
    wireguard-tools
    wireshark
    obsidian
    ollama
    remmina
    powershell
    protonup-qt
    wineWowPackages.stable
    winetricks
    bottles

    # Gaming
    lutris
    steam
    pcsx2
    dolphin-emu
    prismlauncher

    # Themes
    gnome-extension-manager
    gnome-tweaks
    nordic
    numix-icon-theme-circle

    # GNOME Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.tailscale-status
    gnomeExtensions.user-themes
    gnomeExtensions.wireguard-vpn-extension

    # Social
    signal-desktop
  ];

  fonts.packages = with pkgs; [
    comic-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    roboto-mono
  ];

  # xone - Xbox contoller driver
  hardware.xone.enable = true;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "benjamin" ];

  # Docker
  virtualisation.docker = {
  enable = true;
  };
  
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.tailscale.enable = true;

  system.stateVersion = "24.05"; # Keep as-is when upgrading

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # GPU acceleration - supports Intel and AMD (integrated or discrete)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Intel GPU support (iGPU and Arc discrete)
      intel-media-driver
      intel-compute-runtime
           
      # Vulkan support
      vulkan-loader
      vulkan-tools
    ];
  # 32-bit drivers (Crucial for Wine/Lutris)
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      # vulkan-loader is typically handled inherently by enable32Bit, 
      # but adding pkgsi686Linux.intel-media-driver fills the Intel gap.
    ];
  };
}