{ inputs, ... }: {
  programs.hyprpanel.settings.bar.layouts."*" = {
    left = [
      "dashboard"
      "workspaces"

      "ram"
      "cpu"
    ];
    middle = [  ];
    right = [
      "clock"

      "volume"
      "network"
      "bluetooth"
      "battery"

      "hyprsunset"
      "systray"
      "notifications"
    ];
  };
}
