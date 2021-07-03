{ pkgs, config, ... }:

let
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  home.sessionVariables = { EDITOR = "${pkgs.kakoune}/bin/kak"; };

  programs.kakoune = {
    enable = true;

    config = {
      colorScheme = "gruvbox";
      incrementalSearch = true;

      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = true;
      };

      scrollOff = {
        lines = 5;
        columns = 10;
      };

      showMatching = true;

      showWhitespace = {
        enable = true;
        lineFeed = "¬";
        nonBreakingSpace = "⍽";
        space = " ";
        tab = "→";
        tabStop = " ";
      };

      tabStop = 4;
      indentWidth = 4;

      ui = {
        enableMouse = true;
        assistant = "cat";
        changeColors = true;
        statusLine = "bottom";
      };

      hooks = [
        {
          group = "smarttab";
          name = "InsertChar";
          option = ''"\t"'';
          commands = ''
            try %{
              execute-keys -draft "h<a-h><a-k>\A\h+\z<ret><a-;>;%opt{indentwidth}@"
            }'';
        }
        {
          group = "smarttab";
          name = "InsertDelete";
          option = "' '";
          commands = ''
            try %{
              execute-keys -draft 'h<a-h><a-k>\A\h+\z<ret>i<space><esc><lt>'
            }'';
        }
        {
          group = "lsp";
          name = "WinSetOption";
          option = "filetype=(rust|go|c|cpp|nix)";
          commands = ''
            lsp-enable-window
            lsp-inlay-diagnostics-enable global'';
        }
        {
          group = "lsp";
          name = "WinSetOption";
          option = "filetype=(rust|go|c|cpp)";
          commands = "hook window BufWritePre .* lsp-formatting-sync";
        }
        {
          group = "rust";
          name = "WinSetOption";
          option = "filetype=rust";
          commands = ''
            set-option -add global lsp_server_configuration rust.clippy_preference="on"
            hook window -group rust BufReload .* rust-analyzer-inlay-hints
            hook window -group rust NormalIdle .* rust-analyzer-inlay-hints
            hook window -group rust InsertIdle .* rust-analyzer-inlay-hints
            hook -once -always window WinSetOption filetype=.* %{
              remove-hooks window rust-inlay-hints
            }'';
        }
      ];

      keyMappings = [
        #{
        #mode = "lsp";
        #key = "d";
        #effect = "lsp-definition";
        #docstring = "Show definition";
        #}
        {
          mode = "normal";
          key = "K";
          effect = ":lsp-hover<ret>";
          docstring = "Show hover";
        }
        #{
        #mode = "lsp";
        #key = "D";
        #effect = "lsp-declaration";
        #docstring = "Show declaration of symbol under cursor";
        #}
        #{
        #mode = "lsp";
        #key = "r";
        #effect = "lsp-references";
        #docstring = "Show references to symbol under cursor";
        #}
        #{
        #mode = "lsp";
        #key = "i";
        #effect = "lsp-implementation";
        #docstring = "Show implementation of symbol under cursor";
        #}
        #{
        #mode = "lsp";
        #key = "c";
        #effect = "lsp-code-actions";
        #docstring = "Show menu with possible code actions";
        #}
        #{
        #mode = "lsp";
        #key = "n";
        #effect = "lsp-rename-prompt";
        #docstring = "Rename symbol under cursor";
        #}
      ];
    };

    extraConfig = ''
      # lsp
      eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
    '';

    plugins = with pkgs.kakounePlugins; [ kak-lsp auto-pairs-kak ];
  };

  home.file.".config/kak-lsp/kak-lsp.toml".text = ''
    lsp_hover_max_lines=6
    snippet_support = true
    verbosity = 1
    lsp_diagnostic_line_error_sign = ""
    lsp_diagnostic_line_warning_sign = ""

    [language.c_cpp]
    filetypes = ["c", "cpp"]
    roots = ["compile_commands.json", ".ccls", ".git"]
    command = "ccls"
    # Disable additional information in autocompletion menus that Kakoune inserts into the buffer until https://github.com/ul/kak-lsp/issues/40 gets fixed
    args = ["--init={\"completion\":{\"detailedLabel\":false}}"]

    [language.go]
    filetypes = ["go"]
    roots = ["Gopkg.toml", "go.mod", ".git"]
    command = "gopls"
    formatTool = "gofmt"
    args = ["-mode", "stdio", "-gocodecompletion"]

    [language.zig]
    filetypes = ["zig"]
    roots = ["build.zig"]
    command = "zls"

    [language.rust]
    filetypes = ["rust"]
    roots = ["Cargo.toml", ".git"]
    command = "rust-analyzer"
    formatTool = "rustfmt"
  '';
}
