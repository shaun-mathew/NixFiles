{pkgs, ...}: {
  home.packages = with pkgs; [
    jdk8
    jre8
  ];
}
