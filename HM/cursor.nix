{ pkgs, config, lib, ... }: {
  home = {
    pointerCursor = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
    };
  };
}
