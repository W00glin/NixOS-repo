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

  users.users.kali = {
    isNormalUser = true;
    description = "kali";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    adoptopenjdk-icedtea-web#Java web browser plugin and an implementation of Java Web Start
    aircrack-ng             #WiFi security auditing tools suite
    armitage                #Graphical cyber attack management tool for Metasploit
    amass                   #In-Depth DNS Enumeration and Network Mapping
    autopsy                 #Graphical interface to The Sleuth Kit and other open source digital forensics tools
    bettercap               #Comprehensive suite for man in the middle attacks, but better!
    bloodhound              #Active Directory reconnaissance and attack path management tool
    burpsuite               #Integrated platform for performing security testing of web applications
    dmitry                  #Deepmagic Information Gathering Tool
    dirb                    #Web content scanner
    dirbuster               #Brute force directories and files names on web/application servers
    ettercap                #Comprehensive suite for man in the middle attacks
    eyewitness              #Take screenshots of websites, and identify admin interfaces
    fastfetch               #Actively maintained, feature-rich and performance oriented, neofetch like system information tool
    gemini-cli              #AI agent that brings the power of Gemini directly into your terminal
    gobuster                #Tool used to brute-force URIs, DNS subdomains, Virtual Host names on target web servers
    git                     #Distributed version control system
    gnome-screenshot        #FIXED: was gnome.gnome-screenshot
    gparted                 #Graphical disk partitioning tool
    hashcat                 #Fast password cracker
    htop                    #Interactive process viewer
    img2pdf                 #Convert images to PDF via direct JPEG inclusion
    john                    #John the Ripper password cracker
    netcat                  #Utility which reads and writes data across network connections — LibreSSL implementation
    netdiscover             #Network address discovering tool, developed mainly for those wireless networks without dhcp server, it also works on hub/switched networks
    nikto                   #Web server scanner
    nmap                    #Free and open source utility for network discovery and security auditing
    medusa                  #Speedy, parallel, and modular, login brute-forcer
    mimikatz                #Little tool to play with Windows security
    qemu                    #Generic and open source machine emulator and virtualizer
    steghide                #Open source steganography program
    stegseek                #Tool to crack steganography
    sqlmap                  #Automatic SQL injection and database takeover tool
    tcpdump                 #Network sniffer
    thc-hydra               #Very fast network logon cracker which support many different services
    theharvester            #Gather E-mails, subdomains and names from different public sources
    tmux                    #Terminal multiplexer
    tor-browser             #Privacy-focused browser routing traffic through the Tor network
    unzip                   #Extraction utility for archives compressed in .zip format
    vscode                  #Code editor developed by M$$$$$$
    wafw00f                 #Tool to identify and fingerprint Web Application Firewalls (WAF)
    wordlists               #Collection of wordlists useful for security testing
    wireshark               #Powerful network protocol analyzer
    wpscan                  #Black box WordPress vulnerability scanner
    obsidian                #Powerful knowledge base that works on top of a local folder of plain text Markdown files
    recon-ng                #Full-featured framework providing a powerful environment to conduct web-based reconnaissance
    remmina                 #Remote desktop client written in GTK
    responder               #LLMNR, NBT-NS and MDNS poisoner, with built-in HTTP/SMB/MSSQL/FTP/LDAP rogue authentication server
    powershell              #Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
    yara                    #Tool to perform pattern matching for malware-related tasks
    zap                     #OWASP ZAP proxy

    # Themes
    gnome-extension-manager #Desktop app for managing GNOME shell extensions
    gnome-tweaks            #Tool to customize advanced GNOME 3 options
    nordic                  #Gtk and KDE themes using the Nord color pallete
    numix-icon-theme-circle #Numix icon theme (circle version)

  ];

  fonts.packages = with pkgs; [
    comic-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    roboto-mono
  ];


  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "kali" ];
  
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "24.05"; # Keep as-is when upgrading
  };

  # GPU acceleration (new option names)
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt     # FIXED rename from onevpl-intel-gpu
    ];
  };
}
