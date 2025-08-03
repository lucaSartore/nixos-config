{ config, pkgs, lib, ... }:

{

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;



  # environment.systemPackages = with pkgs; [
  #   kdePackages.breeze-icons
  #   papirus-icon-theme
  # ];
  #
  # environment.plasma6.settings = {
  #   "KDE" = {
  #     LookAndFeelPackage = "org.kde.breezedark.desktop";
  #     widgetStyle = "Breeze";
  #   };
  #   "Icons" = {
  #     Theme = "Papirus-Dark";
  #   };
  #   "KScreen" = {
  #     ScaleFactor = "2";
  #   };
  # };

}
