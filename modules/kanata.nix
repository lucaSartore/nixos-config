{ config, pkgs, lib, ... }:

let
  cloneScript = pkgs.writeShellScript "setup-nvim-repo" ''
    set -eux
    if [ ! -d /home/lucas/.config/kanata ]; then
      ${pkgs.git}/bin/git clone https://github.com/lucaSartore/IT-ProgrammingLayout /home/lucas/.config/kanata
      cd /home/lucas/.config/kanata
      ${pkgs.git}/bin/git remote set-url origin git@github.com:lucaSartore/IT-ProgrammingLayout.git
    fi
  '';
in {

  systemd.services.cloneKanataConfigs = {
    description = "Clone nvim config into .config folder";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "lucas";
      ExecStart = "${cloneScript}";
    };
  };

  services.kanata.enable = true;
  services.kanata.keyboards.main-keyboard.configFile = "/home/lucas/.config/kanata/kanata.kbd";

  systemd.services.kanata-main-keyboard.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = "/home/lucas/.config/kanata/kanata.kbd";
  };
}
