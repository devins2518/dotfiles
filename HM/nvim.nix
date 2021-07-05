{ pkgs, config, lib, ... }:

let
  luaConfig = text: ''
    lua << EOF
    ${text}
    EOF
  '';
  package = pkgs.neovim-nightly;
  tokyonight = pkgs.vimUtils.buildVimPlugin {
    name = "tokyonight.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "tokyonight.nvim";
      rev = "852c9a846808a47d6ff922fcdbebc5dbaf69bb56";
      sha256 = "sha256-SnI2lLGsMe4+1GVlihTv68Y/Kqi9SjFDHOdy5ucAd7o=";
    };
  };
  # TODO: use nixpkgs
  fch = pkgs.vimUtils.buildVimPlugin {
    name = "FixCursorHold.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "antoinemadec";
      repo = "FixCursorHold.nvim";
      rev = "b5158c93563ee6192ce8d903bfef839393bfeccd";
      sha256 = "sha256-/6fpdYCXyqQi+iVcYgZmID4pB6HitL+GWx8ZQffZ0Pg=";
    };
  };
  nvim-comment = pkgs.vimUtils.buildVimPlugin {
    buildPhase = ":";
    configurePhase =":";
    name = "nvim-comment";
    src = pkgs.fetchFromGitHub {
      owner = "terrortylor";
      repo = "nvim-comment";
      rev = "05feb57a7b1f2db36794063fa5e738bbdc12315a";
      sha256 = "sha256-hJJxEw4iTrsW3e7Mxn0YNLH95hFPq4KhoqrXEhr2YUo=";
    };
    doCheck = false;
  };
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  home.sessionVariables = { EDITOR = "${package}/bin/nvim"; };
  home.file.".config/nvim".source = ./nvim;
  home.file.".config/nvim".recursive = true;

  programs.neovim = {
    enable = true;
    package = package;
    withNodeJs = false;
    withRuby = false;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set noerrorbells
      set tabstop=4
      set softtabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set number
      set relativenumber
      set nowrap
      set ignorecase
      set smartcase
      set noswapfile
      set nobackup
      set undodir=~/.config/nvim/undodir
      set undofile
      set incsearch
      set ruler
      set formatoptions=tcqrn1
      set expandtab
      set noshiftround
      set scrolloff=4
      set backspace=indent,eol,start
      set matchpairs+=<:>
      set laststatus=2
      set showmode
      set showcmd
      set hlsearch
      set showmatch
      set splitbelow
      set splitright
      set signcolumn=yes:1
      set mouse=nv
      set numberwidth=2
      set cmdheight=1
      set updatetime=250
      set clipboard=unnamedplus
      set list
      set listchars=tab:▸\ ,eol:¬
      set colorcolumn=100
      autocmd! ColorScheme * highlight! link ColorColumn CursorLine
      set cursorline

      nmap <C-M> :noh<CR>
      nmap / /\v
      vmap / /\v
      nmap <C-j> <C-W><C-J>
      nmap <C-k> <C-W><C-K>
      nmap <C-l> <C-W><C-L>
      nmap <C-h> <C-W><C-H>
      nmap <C-S-.> <C-W>>
      nnoremap <silent> gb <C-^>
      inoremap jk <esc>
      set timeoutlen=100

      augroup remember_folds
        autocmd!
        au BufWinLeave ?* mkview 1
        au BufWinEnter ?* silent! loadview 1
      augroup END
    '';
    plugins = with pkgs.vimPlugins; [

      auto-pairs
      lsp-colors-nvim
      lsp-status-nvim
      lsp_extensions-nvim
      lspsaga-nvim
      markdown-preview-nvim
      vim-go
      vim-nix
      vim-startuptime
      vim-surround
      vim-vsnip
      which-key-nvim

      {
        plugin = tokyonight;
        config = ''
          colorscheme tokyonight

          let g:tokyonight_style = 'night' " available: night, storm
          let g:tokyonight_enable_italic = 1

        '';
      }
      {
        plugin = nvim-colorizer-lua;
        config = ''
          let mapleader = " "
          " needed because home-mananger puts this stuff at the top
          set termguicolors
          lua require "colorizer".setup()
        '';
      }
      {
        plugin = nvim-treesitter;
        config = luaConfig ''
          require'nvim-treesitter.configs'.setup {
            ensure_installed = { "c", "cpp", "go", "gomod", "lua", "nix", "rust", "toml", "yaml", "zig" },
            highlight = {
              enable = true, -- false will disable the whole extension
            },
          }
        '';
      }
      {
        plugin = nvim-bufferline-lua;
        config = "luafile $HOME/.config/nvim/bufferline.lua";
      }
      {
        plugin = gitsigns-nvim;
        config = "luafile $HOME/.config/nvim/gitsigns.lua";
      }
      {
        plugin = zig-vim;
        config = ''
          let g:zig_fmt_autosave = 1
          autocmd BufNewFile,BufRead gyro.zzz set filetype=yaml
        '';
      }
      {
        plugin = nvim-comment;
        config = luaConfig ''
          require('nvim_comment').setup({
            -- Linters prefer comment and line to have a space in between markers
            marker_padding = true,
            -- should comment out empty or whitespace only lines
            comment_empty = false,
            -- Should key mappings be created
            create_mappings = false,
          })

          local function map(mode, lhs, rhs, opts)
              local options = {noremap = true}
              if opts then options = vim.tbl_extend("force", options, opts) end
              vim.api.nvim_set_keymap(mode, lhs, rhs, options)
          end
          map("n", "++", [[:CommentToggle<CR>]], opt)
          map("v", "++", [[:'<,'>CommentToggle<CR>]], opt)
        '';
      }
      {
        plugin = vim-fugitive;
        config = ''
          nmap <leader>gs :G<CR>
          nmap <leader>gj :diffget //3<CR>
          nmap <leader>gf :diffget //2<CR>
        '';
      }
      {
        plugin = nvim-compe;
        config = "luafile $HOME/.config/nvim/nvim-compe.lua";
      }
      {
        plugin = nvim-lspconfig;
        config = "luafile $HOME/.config/nvim/nvim-lspconfig.lua";
      }
      {
        plugin = nvim-tree-lua;
        config = "luafile $HOME/.config/nvim/nvimTree.lua";
      }
      {
        plugin = zig-vim;
        config = ''
          autocmd BufNewFile,BufRead *.zig set filetype=zig
          let g:zig_fmt_autosave = 1
        '';
      }
      {
        plugin = rust-vim;
        config = ''
          augroup rust
            au!
            autocmd FileType rust let g:rustfmt_autosave=1
            autocmd Filetype rust let g:cargo_shell_command_runner="!"
            autocmd FileType rust nmap <leader>cc :Ccheck<CR>
            autocmd FileType rust nmap <leader>cb :Cbuild<CR>
            autocmd FileType rust nmap <leader>cr :Crun<CR>
            autocmd FileType rust nmap <leader>cl :Cclean<CR>
            autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
          augroup END
        '';
      }
      {
        plugin = nvim-ts-rainbow;
        config = luaConfig ''
          require'nvim-treesitter.configs'.setup {
            rainbow = {
              enable = true,
              extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
              max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
              colors = {
                "${vim.blue}",
                "${vim.cyan}",
                "${vim.blue1}",
                "${vim.blue0}",
                "${vim.green1}",
                "${vim.green2}",
                "${vim.fg}",
              },
            }
          }
        '';
      }
      #{
      #plugin = nvim-autopairs;
      #config = luaConfig ''
      #require("nvim-autopairs.completion.compe").setup({
      #  map_cr = true, --  map <CR> on insert mode
      #  map_complete = true -- it will auto insert `(` after select function or method item
      #})
      #'';
      #}
      {
        plugin = galaxyline-nvim;
        config = "luafile $HOME/.config/nvim/statusline.lua";
      }
      {
        plugin = nvim-web-devicons;
        config = "luafile $HOME/.config/nvim/web-devicons.lua";
      }
      {
        plugin = fch;
        config = ''
          let g:cursorhold_updatetime = 100
          autocmd CursorHold * lua require('lspsaga.diagnostic').show_cursor_diagnostics()
        '';
      }
      {
        plugin = indentLine;
        config = ''
          let g:indentLine_enabled = 1
          let g:indentLine_char_list = ['|', '¦', '┆', '┊']
        '';
      }
      {
        plugin = vim-markdown;
        config = ''
          let g:vim_markdown_folding_disabled = 1
          augroup markdown
            au!
            autocmd BufNewFile,BufRead *.md set filetype=markdown
            autocmd FileType markdown set conceallevel=2
            autocmd Filetype markdown set wrap
            autocmd FileType markdown set colorcolumn=
            autocmd FileType markdown set scrolloff=999
            autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>
            autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &
            autocmd InsertCharPre *.md if search('\v(%^|[.!?#-]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
          augroup END
        '';
      }
    ];
  };
}
