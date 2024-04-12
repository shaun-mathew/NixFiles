{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  imports = [./shells ./editors ./programs ./terminals ./languages.nix];
}
