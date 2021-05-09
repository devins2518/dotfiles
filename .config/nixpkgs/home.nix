{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
        "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  home.file.".zshrc".source = ./zshrc;
  home.file.".tmux.conf".source = ./tmux.conf;
  home.file.".p10k.zsh".source = ./p10k.zsh;

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "tmux-256color";

      window = {
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        #ligatures = true;
        size = 11;
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Medium";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Bold Italic";
        };
        bold_italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Bold Italic";
        };
      };

      colors = {
        primary = {
          background = "#0F2123";
          foreground = "#F8F8F2";
        };
        normal = {
          black = "#03130D";
          red = "#D75656";
          green = "#5DBE54";
          yellow = "#E4E65C";
          blue = "#5F7BFF";
          magenta = "#DD78AE";
          cyan = "#32CBCD";
          white = "#FFE5EB";
        };
        bright = {
          black = "#698C8E";
          red = "#FF7F7F";
          green = "#82DD6D";
          yellow = "#FFF190";
          blue = "#90AFFF";
          magenta = "#EAA9CE";
          cyan = "#9CE6E7";
          white = "#FFF0F0";
        };
      };

      background_opacity = 0.8;

      shell = {
        program = "/run/current-system/sw/bin/zsh";
        args = [ "-l" "-c" "tmux new || tmux" ];
      };

    };
  };

  home.file.".config/nvim".source = ./nvim;
  home.file.".config/nvim".recursive = true;
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    vimAlias = true;
    withRuby = false;

    extraConfig = ''
      let mapleader = " " "
      colorscheme sonokai
      "let g:edge_style = "aura"
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
      set termguicolors
      set colorcolumn=100
      set numberwidth=2
      set cmdheight=1
      set updatetime=250
      set clipboard=unnamedplus
      set listchars="tab:▸,eol:¬"
      set list
      " TODO: REMOVE
      "cmd 'highlight CursorLine guibg=#69696'
      nmap <C-M> :noh<CR>
      nmap / /\v
      vmap / /\v
      nmap <C-j> <C-W><C-J>
      nmap <C-k> <C-W><C-K>
      nmap <C-l> <C-W><C-L>
      nmap <C-h> <C-W><C-H>

      nmap <leader>gs :G<CR>
      nmap <leader>gj :diffget //3<CR>
      nmap <leader>gf :diffget //2<CR>

      augroup remember_folds
        autocmd!
        au BufWinLeave ?* mkview 1
        au BufWinEnter ?* silent! loadview 1
      augroup END

    '';
    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-bufferline-lua;
        config = "luafile $HOME/.config/nvim/lua/bufferline/lua.lua";
      }
      {
        plugin = nvim-colorizer-lua;
        config = ''lua require "colorizer".setup()'';
      }
      {
        plugin = gitsigns-nvim;
        config = "luafile $HOME/.config/nvim/lua/gitsigns/lua.lua";
      }
      {
        plugin = nerdcommenter;
        config = ''
          vmap ++ <plug>NERDCommenterToggle<CR>
          nmap ++ <plug>NERDCommenterToggle<CR>
        '';
      }
      #{
      #  plugin = nvim-compe;
      #  config = "luafile $HOME/.config/nvim/lua/nvim-compe/lua.lua";
      #}
      #{
      #  plugin = nvim-lspconfig;
      #  config = "luafile $HOME/.config/nvim/lua/nvim-lspconfig/lua.lua";
      #}
      # TODO: port nvimTree stuff
      {
        plugin = nvim-tree-lua;
        config = "luafile $HOME/.config/nvim/lua/nvimTree/lua.lua";
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
      {
        plugin = nvim-autopairs;
        config = ''lua require("nvim-autopairs").setup()'';
      }
      {
        plugin = galaxyline-nvim;
        config = "luafile $HOME/.config/nvim/lua/statusline/lua.lua";
      }
      {
        plugin = nvim-web-devicons;
        config = "luafile $HOME/.config/nvim/lua/web-devicons/lua.lua";
      }
      {
        plugin = sonokai;
        config = ''
          let g:sonokai_style = 'shusia'
          let g:sonokai_enable_italic = 1
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
        plugin = coc-nvim;
        config = ''
          " coc config
          let g:coc_global_extensions = [
            \ "coc-clangd",
            \ "coc-discord-neovim",
            \ "coc-html",
            \ "coc-json",
            \ "coc-pairs",
            \ "coc-prettier",
            \ "coc-python",
            \ "coc-rust-analyzer",
            \ "coc-sh",
            \ "coc-snippets",
            \ "coc-toml",
            \ ]

          " Use <C-k> for jump to previous placeholder, it"s default of coc.nvim
          let g:coc_snippet_prev = "<c-k>"

          " Rename symbol
          nmap <leader>rn <Plug>(coc-rename)

          inoremap <silent><expr> <TAB>
                \ pumvisible() ? coc#_select_confirm() :
                \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request("doKeymap", ["snippets-expand-jump",""])\<CR>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

          function! s:check_back_space() abort
            let col = col(".") - 1
            return !col || getline(".")[col - 1]  =~# "\s"
          endfunction

          " from readme
          " if hidden is not set, TextEdit might fail.
          set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it"s default 4000.
          set updatetime=300

          " GoTo code navigation.
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)
          nnoremap <silent> K :call <SID>show_documentation()<CR>
          nnoremap <silent> gh :call <SID>show_documentation()<CR>
          inoremap <silent><expr> <c-space> coc#refresh()
          nnoremap <silent> gb <C-^>

          " Show documentation
          function! s:show_documentation()
            if &filetype == "vim"
              execute "h ".expand("<cword>")
            else
              call CocAction("doHover")
            endif
          endfunction
        '';
      }

    ];

  };

}

