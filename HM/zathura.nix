{ pkgs, config, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  programs.zathura = {
    enable = true;

    options = {
      font = "tenderness 12";

      default-bg = vim.bg;
      default-fg = bright.white;

      statusbar-bg = vim.fg_gutter;
      statusbar-fg = bright.white;

      inputbar-bg = vim.fg_gutter;
      inputbar-fg = vim.blue;

      notification-bg = bright.white;
      notification-fg = vim.terminal_black;

      notification-error-bg = vim.red;
      notification-error-fg = vim.terminal_black;

      notification-warning-bg = bright.yellow;
      notification-warning-fg = vim.terminal_black;

      highlight-color = vim.blue0;
      highlight-active-color = vim.blue;

      completion-bg = vim.fg_gutter;
      completion-fg = vim.blue;

      completion-highlight-bg = vim.bg;
      completion-highlight-fg = bright.white;

      recolor-lightcolor = vim.bg;
      recolor-darkcolor = bright.white;

      recolor = true;
      recolor-keephue = true;

      show-recent = 0;
      selection-clipboard = "clipboard";
      window-title-basename = true;
      statusbar-basename = true;
    };
  };
}
