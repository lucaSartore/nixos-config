{ config, pkgs, inputs, lib, ... }: {

  imports = [ 
    ./hyprland.home.panels.nix
  ];

  xdg.configFile."hypr/hyprland.conf".source = ../assets/hyprland/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../assets/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/wallpapers" = {
    source = ../assets/wallpapers;
    recursive = true;
  };

  xdg.configFile."rofi/config.rasi".source = ../assets/hyprland/config.rasi;
  xdg.configFile."rofi/themes" = {
    source = ../assets/submodules/rofi_themes_collection;
    recursive = true;
  };
  xdg.configFile."wlr-which-key/config.yaml".source = ../assets/hyprland/which-key.yaml;
}
