{ config, pkgs, lib, inputs, ... }:

{

  boot.loader = {
    efi = { canTouchEfiVariables = true; };
    grub = {
      # Bootloader.
      enable = true;
      devices = [ "nodev" ];
      # efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };

  nix.settings = {
    # enabling flakes
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    description = "Luca Sartore";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  # Allow unfree packages (better for driver compatibility)
  nixpkgs.config.allowUnfree = true;

  # default os packages
  environment.systemPackages = with pkgs; [
    # utility
    pkgs.openssh_hpn
    pkgs.git
    pkgs.git-credential-manager
    pkgs.google-chrome
    pkgs.home-manager
    pkgs.fd
    pkgs.vscode
    pkgs.kdePackages.krohnkite
    pkgs.conda
    pkgs.dotnetCorePackages.sdk_9_0-bin
    pkgs.dotnetCorePackages.sdk_8_0-bin
    pkgs.postman
    pkgs.discord
    pkgs.kdePackages.partitionmanager
    pkgs.openvpn
    pkgs.remmina #remote desktop
    pkgs.anydesk
    pkgs.zoom-us

    # Database drivers
    pkgs.dbeaver-bin # server client UI
    pkgs.libmysqlclient # dependency of mariadb's python package
    pkgs.libmysqlclient.dev

    # Office and other programs
    pkgs.libreoffice-qt6-fresh
    pkgs.xournalpp
    pkgs.rnote

    # for browser integration
    pkgs.libsForQt5.plasma-browser-integration

    # themes
    pkgs.papirus-icon-theme
    pkgs.darkly


    pkgs.acl
  ];

  # nixpkgs.overlays = [
  #     (final: prev: {
  #       libmysqlclient = prev.libmysqlclient.overrideAttrs (_: {
  #         # src = prev.fetchFromGitHub
  #         #   { 
  #         #     owner= "lucaSartore";
  #         #     # owner= "NixOS";
  #         #     repo="nixpkgs";
  #         #     rev="nixos-25.05";
  #         #     hash="sha256-cPiGVx8I5qOq++8U/7vUMQ+k/WgYv+2qOY67pD/c/M8=";
  #         #  };
  #
  #
  #         postFixup = ''
  #           ln -sv mariadb_config $dev/bin/mysql_config
  #           ln -sv mariadb $out/lib/mysql
  #           ln -sv mariadb $dev/include/mysql
  #           ln -sv mariadb_version.h $dev/include/mariadb/mysql_version.h
  #           ln -sv libmariadb.pc $dev/lib/pkgconfig/mysqlclient.pc
  #           install -Dm644 include/ma_config.h $dev/include/mariadb/my_config.h
  #
  #           # The dynamically loaded library must be found directly inside /lib
  #           # This is necessary for nix-ld to work properly
  #           # https://github.com/nix-community/nix-ld
  #           ln -sv $out/lib/mysql/*.so $out/lib
  #           ln -sv $out/lib/mysql/*.so.3 $out/lib
  #           ln -sv $out/lib/mysql/*.a $out/lib
  #         '';
  #       });
  #     })
  # ];

  # Use same standard in linux and windows
  time.hardwareClockInLocalTime = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs;
    [
      # Add any missing dynamic libraries (.so) for unpackaged programs
      # "/home/lucas/Desktop/nixpkgs/pkgs/servers/sql/mariadb"
      # (pkgs.callPackage /home/lucas/Desktop/nixpkgs/pkgs/servers/sql/mariadb { })
      # (import /home/lucas/Desktop/nixpkgs/pkgs/servers/sql/mariadb { inherit pkgs; })
      pkgs.libmysqlclient # dependency of mariadb's python package
      pkgs.libmysqlclient.dev
    ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # NEVER CHANGE THIS, EVEN IF SISTEM IS UPDATED
  # Or perhaps read the docs before changing it
  system.stateVersion = "25.05";
}
