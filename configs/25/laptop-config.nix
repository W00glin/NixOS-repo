{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos_asus";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

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

  # X11 + GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
  };

  services.printing.enable = true;

  # PipeWire + Pulse
  services.pulseaudio.enable = false;   # replaced hardware.pulseaudio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.benjamin = {
    isNormalUser = true;
    description = "Benjamin";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    audacity
    calibre
    cutecom
    easyeffects
    fastfetch
    git
    gnome-screenshot        # FIXED: was gnome.gnome-screenshot
    gparted
    htop
    handbrake
    img2pdf
    ipmitool
    localsend
    nmap
    qemu
    tldr
    tmux
    tor-browser
    unzip
    vscode
    waydroid
    wireshark
    obsidian
    ollama
    remmina
    powershell
    protonup-qt

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

    # Social
    signal-desktop
  ];

  fonts.packages = with pkgs; [
    comic-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    roboto-mono
  ];

  # xone - Xbox contoller driver
  hardware.xone.enable = true;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "benjamin" ];
  
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

  # GPU acceleration (new option names)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt     # FIXED rename from onevpl-intel-gpu
    ];
  };
}
