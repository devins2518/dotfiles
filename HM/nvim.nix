{ pkgs, config, lib, ... }:

let
  package =
    pkgs.neovim-nightly.overrideAttrs (oldAttrs: rec { NIX_LDFLAGS = [ ]; });
  ext = if pkgs.stdenv.isLinux then ".so" else ".dylib";
in {
  home.sessionVariables = { EDITOR = "${package}/bin/nvim"; };
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."nvim".recursive = true;
  xdg.configFile."nvim/parser/bash${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
  # Breaks with header files
  xdg.configFile."nvim/parser/c${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
  xdg.configFile."nvim/parser/comment${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-comment}/parser";
  xdg.configFile."nvim/parser/cpp${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-cpp}/parser";
  xdg.configFile."nvim/parser/go${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-go}/parser";
  xdg.configFile."nvim/parser/haskell${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-haskell}/parser";
  xdg.configFile."nvim/parser/json${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-json}/parser";
  xdg.configFile."nvim/parser/lua${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
  xdg.configFile."nvim/parser/nix${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
  xdg.configFile."nvim/parser/ocaml${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-ocaml}/parser";
  xdg.configFile."nvim/parser/python${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
  xdg.configFile."nvim/parser/rust${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
  xdg.configFile."nvim/parser/toml${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-toml}/parser";
  xdg.configFile."nvim/parser/zig${ext}".source =
    "${pkgs.tree-sitter.builtGrammars.tree-sitter-zig}/parser";

  home.packages = [ package ];
  programs.zsh.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };
}
