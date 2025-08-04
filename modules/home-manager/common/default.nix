{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [./btop];
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
    clipboard-jh
    lazygit

    #nix
    alejandra

    #nerdfonts
    nerd-fonts.code-new-roman
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.fira-code
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}
