{ config, pkgs, ... }:

{
    home.username = "simon-freybler";
    home.homeDirectory = "/home/simon-freybler";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
      fastfetch
    ];
    programs = {
      bash = {
        enable = true;
        initExtra = ''
          export PS1='\[\e[96;3m\]\w\n\[\e[0m\]\\$ ' 
        '';
      };
    };
    home.file.".config/nvim".source = ./config/nvim;
    home.file.".config/waybar".source = ./config/waybar;
    home.file.".config/mako".source = ./config/mako;
    home.file.".local/share/rofi".source = ./config/rofi;
    home.file.".config/hypr".source = ./config/hypr;
}
