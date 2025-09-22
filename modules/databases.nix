{ config, pkgs, lib, inputs, ... }:

{
  # mariadb server
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  users.mysql.user = "lucas";
  users.mysql.passwordFile = "/run/secrets/mysql-auth-db-passwd";
}
