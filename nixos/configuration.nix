# configuration.nix
{ config, pkgs, pkgs-stable, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.hostName = "nixos";
  
  # Static IP configuration
  networking.useDHCP = false;
  networking.interfaces.ens18 = {
    ipv4.addresses = [ {
      address = "192.168.1.15";
      prefixLength = 24; # Subnet mask
    } ];
  };
  
  # Default gateway configuration
  networking.defaultGateway = "192.168.1.1";
  
  # DNS configuration
  networking.nameservers = [ 
    "192.168.1.1"     # Your router DNS
    "1.1.1.1"         # Cloudflare DNS (backup)
    "8.8.8.8"         # Google DNS (backup)
  ];
  
  # Disable NetworkManager to avoid conflicts with static IP
  networking.networkmanager.enable = false;
  
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 8080 9000 ];
  
  # Time zone and locale
  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_CH.UTF-8";
    LC_IDENTIFICATION = "fr_CH.UTF-8";
    LC_MEASUREMENT = "fr_CH.UTF-8";
    LC_MONETARY = "fr_CH.UTF-8";
    LC_NAME = "fr_CH.UTF-8";
    LC_NUMERIC = "fr_CH.UTF-8";
    LC_PAPER = "fr_CH.UTF-8";
    LC_TELEPHONE = "fr_CH.UTF-8";
    LC_TIME = "fr_CH.UTF-8";
  };

  # User configuration
  users.users.nixos = {
    isNormalUser = true;
    description = "NixOS User";
    extraGroups = [ "wheel" "docker" ];  # Removed networkmanager as it's disabled
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      # SSH key for user nixos
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4eiTftWXVdB5OtQ5TQ8GaVx0WOrfulIJlsxTIZhOfB macOS"
    ];
  };

  # Root user configuration (optional, for emergency access)
  users.users.root.openssh.authorizedKeys.keys = [
    # SSH key for root user
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4eiTftWXVdB5OtQ5TQ8GaVx0WOrfulIJlsxTIZhOfB macOS"
  ];

  # Enable SSH service
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;  # Allow password authentication
      PermitRootLogin = "prohibit-password";  # Root can only use SSH keys
      X11Forwarding = false;
      MaxAuthTries = 3;
    };
  };

  # Docker configuration
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Essential tools
    vim
    nano
    wget
    curl
    git
    unzip
    zip
    tree
    btop
    
    # Docker tools
    docker
    docker-compose
    
    # Network tools
    dig
    nmap
    netcat
    
    # System monitoring
    iotop
    lsof
  ];

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Auto-upgrade system
  system.autoUpgrade = {
    enable = false; # Disabled because we do it via CI/CD
    flake = "/etc/nixos";
  };

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # System state version
  system.stateVersion = "24.11";

  # Journald configuration for log retention
  services.journald.extraConfig = ''
    SystemMaxUse=1G
    MaxRetentionSec=1month
  '';
}