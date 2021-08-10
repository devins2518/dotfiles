{ pkgs, config, lib, ... }: {
  xsession = {
    pointerCursor = {
      name = "Quintom_Ink";
      package = pkgs.quintom-cursor-theme;
    };
  };
}
