{ inputs, pkgs, ... }:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    iconTheme.name = "Papirus-Dark";
    theme.name = "Adwaita";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      "gtk-cursor-theme-name" = "Bibata-Modern-Classic";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      Settings = ''
        gtk-cursor-theme-name=Bibata-Modern-Classic
        '';
    };
  };

  # custom cursor icon instead of hyprland's one
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };
}
