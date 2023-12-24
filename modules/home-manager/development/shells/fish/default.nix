{pkgs, lib, config, dotfiles, ...}:
let
configPath = pkgs.lib.concatStringsSep "/" [dotfiles "modules/home-manager/development/shells/fish/config"];
in
{

  home.packages = with pkgs; [
    fish

    #fish plugins
    fishPlugins.colored-man-pages
    fishPlugins.autopair
    fishPlugins.puffer
    fishPlugins.forgit
  ];

  xdg.configFile."fish" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink configPath;
  };


}
