{
  pkgs,
  ...
}:
{
  systemd.services.disk-monitor = {
    description = "";

    script = '''';
    serviceConfig = {
      Type = "simple";
    };
  };
}
