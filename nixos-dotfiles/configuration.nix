{ config, lib, pkgs, ... }:

{
  imports =
    [       
      ./hardware-configuration.nix
    ];
  
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NixOS";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  console = {
    keyMap = "de";
  };
  
  i18n.defaultLocale = "C.UTF-8";
 
  users.users.simon-freybler = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      nvidiaSettings = false;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    sane = {
      enable = true;
      brscan4 = {
        enable = true;
        netDevices = {
          home = { model = "MFC-L2710DW"; ip = "192.168.178.30"; };
        };
      };
    };
  };
      
  services = {
    flatpak.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "de";
        variant = "e1";
      };
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin = {
        enable = true;
        user = "simon-freybler";
      };
    };
    blueman.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };
  };

  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-vcs-plugin
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        yaru-theme
      ];
    };
    gamemode.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      ubuntu-sans
      nerd-fonts.ubuntu-sans
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    file-roller
    git
    kitty
    yaru-theme
    nwg-look
    pavucontrol
    rofi
    waybar
    hyprshot
    hyprpaper
    mako
    libnotify
    openrgb
    brave
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
