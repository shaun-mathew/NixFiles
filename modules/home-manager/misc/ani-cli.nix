{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  dotfiles,
  ...
}: {
  home.packages = with pkgs;
    [
      #dependencies
      mpv
      aria
      yt-dlp
      ffmpeg
    ]
    ++ [
      pkgs-unstable.ani-cli
    ];
}
