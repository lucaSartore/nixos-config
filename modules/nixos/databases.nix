{ config, pkgs, lib, inputs, ... }:
let
  mysqlInit = pkgs.writeText "mysql-init.sql" ''
    CREATE USER IF NOT EXISTS 'lucas'@'localhost' IDENTIFIED BY 'dummy_password';
    GRANT ALL PRIVILEGES ON *.* TO 'lucas'@'localhost';
    FLUSH PRIVILEGES;
  '';
in {

  # mariadb server
  # host: localhost
  # port: 3306
  # username: lucas
  # password: dummy_password
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialScript = mysqlInit;
  };
}
