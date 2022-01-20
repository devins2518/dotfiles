{ pkgs, config, lib, ... }:

let package = pkgs.neovim-nightly;
in {
  home.sessionVariables = { EDITOR = "${package}/bin/nvim"; };
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."nvim".recursive = true;
  xdg.configFile."nvim/parser/bash.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
  # Breaks with header files
  xdg.configFile."nvim/parser/c.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/cpp.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-cpp}/parser";
  xdg.configFile."nvim/parser/comment.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-comment}/parser";
  xdg.configFile."nvim/parser/go.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-go}/parser";
  xdg.configFile."nvim/parser/haskell.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-haskell}/parser";
  xdg.configFile."nvim/parser/json.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-json}/parser";
  xdg.configFile."nvim/parser/lua.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/nix.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/python.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  # xdg.configFile."nvim/parser/rust.so".source =
  #   "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/toml.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-toml}/parser";
  xdg.configFile."nvim/parser/zig.so".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-zig}/parser";

  home.packages = [ package ];
  programs.zsh.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };
}
