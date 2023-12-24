{pkgs, lib, config, dotfiles,...}:

{
  imports = [
    ./bat.nix
    ./starship.nix
    ./git.nix
    ./sshfs.nix
    ./lf
    ./tmux
  ];

}
