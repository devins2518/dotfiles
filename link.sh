#!/bin/sh
REPO=$HOME/Repos/dotfiles
rm -r $REPO/.config/nixpkgs
sudo rm -r $REPO/configuration.nix
mkdir -p $REPO/.config/nixpkgs/nvim/lua/{bufferline,gitsigns,mappings,nvim-compe,nvim-lspconfig,nvimTree,pluginList,rust,statusline,telescope-nvim,treesitter,utils,web-devicons}

ln ~/.config/nixpkgs/home.nix $REPO/.config/nixpkgs/home.nix
ln ~/.config/nixpkgs/p10k.zsh $REPO/.config/nixpkgs/p10k.zsh
ln ~/.config/nixpkgs/zshrc $REPO/.config/nixpkgs/zshrc
ln ~/.config/nixpkgs/nvim/init.lua $REPO/.config/nixpkgs/nvim/init.lua
ln ~/.config/nixpkgs/nvim/lua/coc.vim $REPO/.config/nixpkgs/nvim/lua/coc.vim
ln ~/.config/nixpkgs/nvim/lua/bufferline/lua.lua $REPO/.config/nixpkgs/nvim/lua/bufferline/lua.lua
ln ~/.config/nixpkgs/nvim/lua/gitsigns/lua.lua $REPO/.config/nixpkgs/nvim/lua/gitsigns/lua.lua
ln ~/.config/nixpkgs/nvim/lua/mappings/lua.lua $REPO/.config/nixpkgs/nvim/lua/mappings/lua.lua
ln ~/.config/nixpkgs/nvim/lua/nvim-compe/lua.lua $REPO/.config/nixpkgs/nvim/lua/nvim-compe/lua.lua
ln ~/.config/nixpkgs/nvim/lua/nvim-lspconfig/lua.lua $REPO/.config/nixpkgs/nvim/lua/nvim-lspconfig/lua.lua
ln ~/.config/nixpkgs/nvim/lua/nvimTree/lua.lua $REPO/.config/nixpkgs/nvim/lua/nvimTree/lua.lua
ln ~/.config/nixpkgs/nvim/lua/pluginList/lua.lua $REPO/.config/nixpkgs/nvim/lua/pluginList/lua.lua
ln ~/.config/nixpkgs/nvim/lua/rust/lua.lua $REPO/.config/nixpkgs/nvim/lua/rust/lua.lua
ln ~/.config/nixpkgs/nvim/lua/statusline/lua.lua $REPO/.config/nixpkgs/nvim/lua/statusline/lua.lua
ln ~/.config/nixpkgs/nvim/lua/telescope-nvim/lua.lua $REPO/.config/nixpkgs/nvim/lua/telescope-nvim/lua.lua
ln ~/.config/nixpkgs/nvim/lua/treesitter/lua.lua $REPO/.config/nixpkgs/nvim/lua/treesitter/lua.lua
ln ~/.config/nixpkgs/nvim/lua/utils/lua.lua $REPO/.config/nixpkgs/nvim/lua/utils/lua.lua
ln ~/.config/nixpkgs/nvim/lua/web-devicons/lua.lua $REPO/.config/nixpkgs/nvim/lua/web-devicons/lua.lua
sudo ln /etc/nixos/configuration.nix $REPO/configuration.nix
