{config, pkgs, pkgs-unstable, ...}:

{
  imports = [
    ./btop.nix
  ];
  home.packages = with pkgs; [
    #shell utilities
    neofetch
    htop
    zoxide
    fzf
    tealdeer
    trash-cli
    fd
    ripgrep
    eza
    
    #nerdfonts
    (nerdfonts.override { fonts = [ "CodeNewRoman" "Iosevka" "IosevkaTerm" "FiraCode"]; })
  ];
}
