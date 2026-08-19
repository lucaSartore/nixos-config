{ lib, configName, ... }:
let
  isLaptop = lib.hasInfix "laptop" configName;
  centerWidgets = [
    "clock"
  ];
  leftWidgets = [
    "dashboard"
    "hyprland-workspaces"
    "cpu"
    "ram"
    "netstat"
  ];

  rightWidgets = lib.optionals isLaptop [
    "bluetooth"
    "battery"
  ] ++ [
    "weather"
    "network"
    "volume"
    "systray"
    "notifications"
  ];
in
{
  services.wayle = {

    enable = true;

    autoInstallDependencies = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)'
    settings = {
      bar = {
        button-bg-opacity = 0;
        button-variant = "basic";
        background-opacity = 30;
        bg = "#000000";
        button-icon-size = 0.75;
        button-rounding = "none";
        padding = 0;
        layout = [
          {
            monitor = "*";
            center = centerWidgets;
            left = leftWidgets;
            right = rightWidgets;
            show = true;
          }
        ];
        scale = 0.75;
      };
      modules = {
        weather = {
          location = "Schio";
          units = "metric";
        };
      };
      osd = {
        monitor = "DP-1";
      };
      styling = {
        scale = if isLaptop then 0.75 else 1.0;
        # one dark
        palette = {
          blue = "#56b6c2";
          elevated = "#3e4451";
          fg = "#abb2bf";
          fg-muted = "#5c6370";
          green = "#98c379";
          primary = "#61afef";
          red = "#e06c75";
          surface = "#282c34";
          yellow = "#e5c07b";
        };
      };
    };
  };
}
