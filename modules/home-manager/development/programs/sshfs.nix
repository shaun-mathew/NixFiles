{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  home.packages = with pkgs; [sshfs];
}
