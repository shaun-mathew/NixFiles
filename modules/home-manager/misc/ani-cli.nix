{
  pkgs,
  lib,
  config,
  dotfiles,
  ...
}: {
  home.packages = with pkgs; [
    ani-cli

    #dependencies
    mpv
    aria
    yt-dlp
    ffmpeg
  ];
}
