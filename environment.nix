{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      wget vim
      lxappearance arandr
      zsh
      networkmanagerapplet
      binutils gcc gnumake openssl pkgconfig zlib
    ];

    pathsToLink = [ "/libexec" ];

    variables = {
      EDITOR = "nvim";
      FZF_BASE = [ "${pkgs.fzf}/share/fzf" ];
      LD_LIBRARY_PATH = [ "$HOME/.nix-profile/lib" ];
      PATH = [ "$HOME/bin/" ];
      QT_AUTO_SCREEN_SCALE_FACTOR= "0";
      QT_SCALE_FACTOR = "1.25";
      QT_QPA_PLATFORMTHEME = [ "qt5ct" ];
      TERMINAL = [ "alacritty" ];
      XCURSOR_SIZE = "28";
      ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
    };
  };
}
