{ config, pkgs, lib, ... }:

{
  systemd.services.cloneConfigs = {
    description = "Clone neovim config into .config";
    after = [ "network.target" "home.mount" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "lucas";
      ExecStart = "${pkgs.git}/bin/git clone git@github.com:lucaSartore/nvim.git /home/lucas/.config/nvim-test";
    };
  };
}
