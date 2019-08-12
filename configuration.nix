# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  nixpkgs.config = {
    allowUnfree = true;
  };
  
  boot.loader.grub = {
    enable = true;
    version = 2;
    useOSProber = true;
    device = "/dev/sda"; 
   };

  time.timeZone = "Europe/Berlin";

  environment = {
    systemPackages = with pkgs; [ 
      wget 
      vim 
      git 
      compton 
      ranger 
      zsh
      tmux 
      rofi 
      chromium 
      vlc 
      st 
      zip 
      unzip 
      thunderbird 
      vscode
      discord 
      transmission 
      feh 
      terminator
      termite 
      cmake 
      clang 
      arandr 
      pavucontrol 
      wine 
      winetricks 
      scrot
      
      ];

    pathsToLink = [ "/libexec" ];
  };
  
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    wacom.enable = true;
    videoDrivers = [ "nvidia" ];

    windowManager.i3 = { 
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
    
    desktopManager.xfce = {
      enable = true;
    };

  };
  hardware.opengl.driSupport32Bit = true;

  fileSystems = {
	"/mnt/mass-storage" = {
		device = "/dev/disk/by-id/ata-ST2000DM001-1CH164_Z1E7S4F8-part1";
		fsType = "ntfs";
	};
 };

    users.users.genkinger = {
      	isNormalUser = true;
      	extraGroups = [ "wheel" "audio" "video" ];
	      home = "/home/genkinger";
	      description = "Lukas Genkinger";
    };

  system.stateVersion = "19.03"; # Did you read the comment?

  boot.supportedFilesystems = [ "zfs" ];

  networking = {
	  hostId = "DEADBEEF";
	  hostName =  "VirgoNix";
  };

  fonts = {
    fontconfig.enable = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      source-code-pro
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

}
