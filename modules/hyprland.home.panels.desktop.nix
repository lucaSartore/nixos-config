{ inputs, ... }: {
  programs.hyprpanel.settings.bar.layouts."*" = {
    left = [
      "dashboard"
      "workspaces"

      "separator" # ########

      "ram"
      "cpu"
      "cputemp"
      "netstat"
    ];
    middle = [ ];
    right = [

      "media"
      "clock"

      "separator" # ########

      "volume"
      "network"

      "separator" # ########

      "hyprsunset"
      "systray"
      "notifications"
      "power"
    ];
  };
}
