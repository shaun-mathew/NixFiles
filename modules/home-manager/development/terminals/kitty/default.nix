{pkgs, libs, config, ...}:

{
  xdg.configFile."kitty" = {
    recursive = true;
    source = ./config;
  };
}
