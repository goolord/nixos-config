# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./environment.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./rice.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # kernel stuff, graphics stuff
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ 
    "amd_iommu=pt" 
    "ivrs_ioapic[32]=00:14.0" 
    "iommu=soft" "acpi_osi=" 
  ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.zach = {
    isNormalUser = true;
    extraGroups = [ "sudo" "wheel" "networkmanager" "video" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  hardware.brightnessctl.enable = true;

  # Enable zsh
  programs.zsh.enable = true;

  # Enable Oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    custom = "/home/zach/.oh-my-zsh/custom/";
    plugins = [ "git" "sudo" "fzf" "zsh-autosuggestions" "nix-shell" ];
    theme = "ysn";
  };

}

