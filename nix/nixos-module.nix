{ config, lib, pkgs, ...}:
with lib;
let
  cfg = config.services.pp-to-amd-epp;
in {
  options.services.pp-to-amd-epp = {
    enable = mkEnableOption "pp-to-amd-epp";
    package = mkOption {
      type = types.package;
      default = self.packages.${pkgs.system}.default;
      description = mdDoc ''
        Package to use for pp-to-amd-epp service.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.pp-to-amd-epp = {
      description = "Power Profiles Daemon to AMD-PSTATE EPP";
      wantedBy = [ "multi-user.target" ];
      requires = [ "power-profiles-daemon.service" ];
      after = [ "power-profiles-daemon.service" ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        User = "root";
        ExecStart = "${lib.getExe cfg.package}";
      };
    };
  };


} 
