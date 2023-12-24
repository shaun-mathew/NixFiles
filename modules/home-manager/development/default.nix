{pkgs, lib, config, dotfiles,...}:

{
  imports = [
    ./shells
    ./editors
    ./programs
    ./terminals
  ];

}
