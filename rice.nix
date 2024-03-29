{ config, pkgs, ... }:

{
  # compton
  services.compton = {
    enable = true;
    fade = false;
    shadow = false;
    backend = "glx";
    vSync = true;
  };

  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;

    displayManager = {
      lightdm = {
        enable = true;
        greeters.gtk = {
          theme = { 
            package = pkgs.numix-gtk-theme;
            name = "Numix";
          };
          iconTheme = {
            package = pkgs.numix-icon-theme;
            name = "Numix";
          };
        };
      };
    };
    
    desktopManager = {
      default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };

  };

}
