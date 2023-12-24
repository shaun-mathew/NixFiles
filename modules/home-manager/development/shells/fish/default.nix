{pkgs, lib, config, dotfiles, ...}:
let
  #when mkOutOfStoreSymlink gets fixed
  fishPath = pkgs.lib.concatStringsSep "/" [dotfiles "modules/home-manager/development/shells/fish/config"];
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

  xdg.configFile."fish".source = lib.mkForce ./config;

  #xdg.configFile."fish".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink fishPath);

}
