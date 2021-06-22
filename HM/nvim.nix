{ pkgs, config, ... }:

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
  truezen = pkgs.vimUtils.buildVimPlugin {
    name = "TrueZen.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Pocco81";
      repo = "TrueZen.nvim";
      rev = "6009da02423ad5a327bb9e07c8c7c0928e77edc9";
      sha256 = "sha256-atETWiyJA71KI6YAUGeKsDbLq8o+8vOKZF6q34bMhr0=";
    };
  };
  theme = import ./colors.nix { };
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

      augroup remember_folds
        autocmd!
        au BufWinLeave ?* mkview 1
        au BufWinEnter ?* silent! loadview 1
      augroup END
    '';
    plugins = with pkgs.vimPlugins; [

      auto-pairs
      lsp-status-nvim
      lspsaga-nvim
      markdown-preview-nvim
      vim-easyescape
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
              enable = true,              -- false will disable the whole extension
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
        plugin = nerdcommenter;
        config = ''
          vmap ++ <plug>NERDCommenterToggle<CR>
          nmap ++ <plug>NERDCommenterToggle<CR>
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
        plugin = lsp_signature-nvim;
        config = luaConfig ''
          cfg = {
            bind = false, -- This is mandatory, otherwise border config won't get registered.
            doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);

            floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
            hint_enable = true, -- virtual hint enable
            hint_scheme = "String",
            use_lspsaga = false,  -- set to true if you want to use lspsaga popup
            hi_parameter = "Search", -- how your parameter will be highlight
            max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                             -- to view the hiding contents
            max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
            handler_opts = {
              border = "shadow"   -- double, single, shadow, none
            },
          }

          require'lsp_signature'.on_attach(cfg)
        '';
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
          let g:rustfmt_autosave=1
          let g:cargo_shell_command_runner="!"
          nmap <leader>cc :Ccheck<CR>
          nmap <leader>cb :Cbuild<CR>
          nmap <leader>cr :Crun<CR>
          nmap <leader>cl :Cclean<CR>
        '';
      }
      #{
      #plugin = nvim-autopairs;
      #config = ''lua require("nvim-autopairs").setup()'';
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
        plugin = indentLine;
        config = ''
          let g:indentLine_enabled = 1
          let g:indentLine_char_list = ['|', '¦', '┆', '┊']
        '';
      }
      {
        plugin = truezen;
        config = ''
          augroup markdown
            au!
            autocmd BufNewFile,BufRead *.md set filetype=markdown
            autocmd FileType markdown set conceallevel=2
            autocmd Filetype markdown set wrap
            autocmd FileType markdown set colorcolumn=
            autocmd FileType markdown set scrolloff=999
            autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>
            autocmd FileType markdown nmap <leader>tz :TZAtaraxis<CR>
            autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &
            augroup SENTENCES
            autocmd InsertCharPre *.md if search('\v(%^|[.!?]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
          augroup END

        '' + luaConfig ''
          local true_zen = require("true-zen")

          -- setup for TrueZen.nvim
          true_zen.setup({
              ataraxis = {
                  ideal_writing_area_width = 0,
                  just_do_it_for_me = false,
                  left_padding = 5,
                  right_padding = 5,
                  top_padding = 3,
                  bottom_padding = 3,
                  quit_untoggles_ataraxis = false
              },
              integrations = {
                integration_galaxyline = true,
                integration_gitgutter = true,
              }
          })
        '';
      }
      {
        plugin = vim-markdown;
        config = ''
          let g:vim_markdown_folding_disabled = 1
        '';
      }
    ];
  };
}
