{ config, pkgs, lib, ... }:

let
  cloneScript = pkgs.writeShellScript "setup-nvim-repo" ''
    set -eux
    if [ ! -d /home/lucas/.config/kanata ]; then
      ${pkgs.git}/bin/git clone https://github.com/lucaSartore/IT-ProgrammingLayout /home/lucas/.config/kanata
      cd /home/lucas/.config/kanata
      ${pkgs.git}/bin/git remote set-url origin git@github.com:lucaSartore/IT-ProgrammingLayout.git

      # since this service is run as a root, we need to transfer ownership to the user
      chown -R lucas:users /home/lucas/.config/kanata
    fi

    # manually start the service (so that we can be sure that the repo has being cloned)
    systemctl start kanata-main-keyboard.service
  '';
in {

  systemd.services.cloneKanataConfigs = {
    description = "Clone nvim config into .config folder";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root"; # this need to be root to execute the systemctl command in the script
      ExecStart = "${cloneScript}";
    };
  };

  services.kanata.enable = true;
  services.kanata.keyboards.main-keyboard.configFile = "/home/lucas/.config/kanata/kanata.kbd";

  # override the default config so that the service does nto start automatically
  systemd.services.kanata-main-keyboard.wantedBy = lib.mkForce [];
  # override the def config to allow access to the config file
  systemd.services.kanata-main-keyboard.serviceConfig = {
    ProtectHome = lib.mkForce "tmpfs";
    BindReadOnlyPaths = "/home/lucas/.config/kanata/kanata.kbd";
  };
}
