{ pkgs, config, lib, ... }:

let
  package = pkgs.neovim-nightly;
  packer = pkgs.vimUtils.buildVimPlugin {
    name = "packer.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "wbthomason";
      repo = "packer.nvim";
      rev = "b6a904b341c56c5386bdd5c991439a834d061874";
      sha256 = "sha256-BNSJsCgCF3bLBIshS+LLJSg0mMmDGB1ShLZsw1mZRsk=";
    };
    opt = true;
  };
  theme = import ./colors.nix { };
  normal = theme.normal;
  bright = theme.bright;
  vim = theme.vim;
in {
  home.sessionVariables = { EDITOR = "${package}/bin/nvim"; };
  xdg.configFile."nvim/plugins".source = ./nvim;
  xdg.configFile."nvim/plugins".recursive = true;

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
      set termguicolors
      let mapleader = " "

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

      lua require'plugins.plugins'
    '';
    plugins = with pkgs.vimPlugins;
      [
        # # markdown-preview-nvim
        packer

        # done
        # {
        #   plugin = tokyonight;
        #   config = ''
        #     let g:tokyonight_style = 'night'
        #     let g:tokyonight_enable_italic = 1

        #     colorscheme tokyonight
        #   '';
        # }
        # done
        # {
        #   plugin = nvim-colorizer-lua;
        #   config = ''
        #     " needed because home-mananger puts this stuff at the top
        #     lua require "colorizer".setup()
        #   '';
        # }
        # done
        # {
        #   plugin = nvim-treesitter;
        #   config = luaConfig ''
        #     require'nvim-treesitter.configs'.setup {
        #       ensure_installed = { "c", "cpp", "go", "gomod", "lua", "nix", "rust", "toml", "yaml", "zig" },
        #       highlight = {
        #         enable = true, -- false will disable the whole extension
        #       },
        #     }
        #   '';
        # }
        # # {
        # #   plugin = nvim-autopairs;
        # #   config = luaConfig ''
        # #     require('nvim-autopairs').setup({
        # #       enable_check_bracket_line = false
        # #     })

        # #     require("nvim-autopairs.completion.compe").setup({
        # #       map_cr = true, --  map <CR> on insert mode
        # #       map_complete = true -- it will auto insert `(` after select function or method item
        # #     })

        # #     require("nvim-treesitter.configs").setup { autopairs = { enable = true } }
        # #   '';
        # # }
        # done
        # {
        #   plugin = nvim-compe;
        #   config = "luafile $HOME/.config/nvim/nvim-compe.lua";
        # }
        # done
        # {
        #   plugin = nvim-lspconfig;
        #   config = "luafile $HOME/.config/nvim/nvim-lspconfig.lua";
        # }
        # done
        # {
        #   plugin = nvim-bufferline-lua;
        #   config = "luafile $HOME/.config/nvim/bufferline.lua";
        # }
        # done
        # {
        #   plugin = telescope-nvim;
        #   config = "luafile $HOME/.config/nvim/telescope-nvim.lua";
        # }
        # done
        # {
        #   plugin = formatter;
        #   config = "luafile $HOME/.config/nvim/format.lua";
        # }
        # done
        # {
        #   plugin = gitsigns-nvim;
        #   config = "luafile $HOME/.config/nvim/gitsigns.lua";
        # }
        # done
        # {
        #   plugin = zig-vim;
        #   config = ''
        #     let g:zig_fmt_autosave = 0
        #     autocmd BufNewFile,BufRead gyro.zzz set filetype=yaml
        #   '';
        # }
        # done
        # {
        #   plugin = nvim-comment;
        #   config = luaConfig ''
        #     require('nvim_comment').setup({
        #       -- Linters prefer comment and line to have a space in between markers
        #       marker_padding = true,
        #       -- should comment out empty or whitespace only lines
        #       comment_empty = false,
        #       -- Should key mappings be created
        #       create_mappings = false,
        #     })

        #     local function map(mode, lhs, rhs, opts)
        #         local options = {noremap = true}
        #         if opts then options = vim.tbl_extend("force", options, opts) end
        #         vim.api.nvim_set_keymap(mode, lhs, rhs, options)
        #     end
        #     map("n", "++", [[:CommentToggle<CR>]], opt)
        #     map("v", "++", [[:'<,'>CommentToggle<CR>]], opt)
        #   '';
        # }
        # done
        # {
        #   plugin = vim-fugitive;
        #   config = ''
        #     nmap <leader>gs :G<CR>
        #     nmap <leader>gj :diffget //3<CR>
        #     nmap <leader>gf :diffget //2<CR>
        #   '';
        # }
        # done
        # {
        #   plugin = nvim-tree-lua;
        #   config = "luafile $HOME/.config/nvim/nvimTree.lua";
        # }
        # done
        # {
        #   plugin = lspsaga-nvim;
        #   config = luaConfig ''
        #     require('lspsaga').init_lsp_saga {
        #       code_action_keys = {
        #         quit = 'q',exec = '<CR>'
        #       },
        #       rename_action_keys = {
        #         quit = 'q',exec = '<CR>'  -- quit can be a table
        #       },
        #     }
        #   '';
        # }
        # done
        # {
        #   plugin = rust-vim;
        #   config = ''
        #     augroup rust
        #       au!
        #       autocmd FileType rust let g:rustfmt_autosave=0
        #       autocmd Filetype rust let g:cargo_shell_command_runner="!"
        #       autocmd FileType rust nmap <leader>cc :Ccheck<CR>
        #       autocmd FileType rust nmap <leader>cb :Cbuild<CR>
        #       autocmd FileType rust nmap <leader>cr :Crun<CR>
        #       autocmd FileType rust nmap <leader>cl :Cclean<CR>
        #       autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{
        #         \ highlight = "NonText",
        #         \ prefix = " » ",
        #         \ enabled = {"TypeHint", "ChainingHint", "ParameterHint"}
        #       \ }
        #     augroup END
        #   '';
        # }
        # done
        # {
        #   plugin = nvim-ts-rainbow;
        #   config = luaConfig ''
        #     require'nvim-treesitter.configs'.setup {
        #       rainbow = {
        #         enable = true,
        #         extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        #         max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        #         colors = {
        #           "${vim.blue}",
        #           "${vim.cyan}",
        #           "${vim.blue1}",
        #           "${vim.blue0}",
        #           "${vim.green1}",
        #           "${vim.green2}",
        #           "${vim.fg}",
        #         },
        #       }
        #     }
        #   '';
        # }
        # done
        # {
        #   plugin = lualine-nvim;
        #   config = "luafile $HOME/.config/nvim/statusline.lua";
        # }
        # done
        # {
        #   plugin = nvim-web-devicons;
        #   config = "luafile $HOME/.config/nvim/web-devicons.lua";
        # }
        # done
        # {
        #   plugin = fch;
        #   config = ''
        #     let g:cursorhold_updatetime = 100
        #     autocmd CursorHold * lua require('lspsaga.diagnostic').show_cursor_diagnostics()
        #   '';
        # }
        # done
        # {
        #   plugin = indentLine;
        #   config = ''
        #     let g:indentLine_enabled = 1
        #     let g:indentLine_char_list = ['|', '¦', '┆', '┊']
        #   '';
        # }
        # done
        # {
        #   plugin = vim-markdown;
        #   config = ''
        #     let g:vim_markdown_folding_disabled = 1
        #     augroup markdown
        #       au!
        #       autocmd BufNewFile,BufRead *.md set filetype=markdown
        #       autocmd FileType markdown set conceallevel=2
        #       autocmd Filetype markdown set wrap
        #       autocmd FileType markdown set colorcolumn=
        #       autocmd FileType markdown set scrolloff=999
        #       autocmd FileType markdown nmap <leader>cp :!compilenote %<CR>
        #       autocmd InsertLeave /home/devin/Repos/notes/*.md silent! !compilenote % &
        #       autocmd InsertCharPre *.md if search('\v(%^|[.!?#-]\_s)\_s*%#', 'bcnw') != 0 | let v:char = toupper(v:char) | endif
        #     augroup END
        #   '';
        # }
      ];
  };
}
