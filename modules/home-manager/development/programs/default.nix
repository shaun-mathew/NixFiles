{pkgs, lib, config, dotfiles,...}:

{
  imports = [
    ./starship.nix
    ./git.nix
    ./sshfs.nix
    ./lf
    ./tmux
    ./bat
  ];

}
