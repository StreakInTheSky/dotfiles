" Vim Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" for normal Neovim
call plug#begin(stdpath('data').'/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/popup.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'NMAC427/guess-indent.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'simrat39/rust-tools.nvim', { 'for': 'rust' }
Plug 'crispgm/nvim-go'
Plug 'mattn/emmet-vim' 
Plug 'Olical/conjure'
Plug 'clojure-vim/vim-jack-in'
Plug 'PaterJason/cmp-conjure'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'jez/vim-better-sml', { 'for': 'sml' }
Plug 'kristijanhusak/orgmode.nvim' 
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

colorscheme tokyonight

set mouse=a
set undofile
set breakindent
set ignorecase
set smartcase
set nohlsearch
set updatetime=250

set noexpandtab
set tabstop=4
set shiftwidth=4

set signcolumn=yes
set number relativenumber

let maplocalleader=","

filetype plugin indent on

"toggles relative number in insert mode
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter	 * set norelativenumber
augroup END


"conjure
let g:conjure#mapping#doc_word = "k"
autocmd BufNewFile conjure-log-* lua vim.diagnostic.disable(0)

" better sml
augroup vimbettersml
	au!

	" ----- Keybindings -----

	au FileType sml nnoremap <silent> <buffer> <leader>t :SMLTypeQuery<CR>
	au FileType sml nnoremap <silent> <buffer> gd :SMLJumpToDef<CR>

	" open the REPL terminal buffer
	au FileType sml nnoremap <silent> <buffer> <leader>is :SMLReplStart<CR>
	" close the REPL (mnemonic: k -> kill)
	au FileType sml nnoremap <silent> <buffer> <leader>ik :SMLReplStop<CR>
	" build the project (using CM if possible)
	au FileType sml nnoremap <silent> <buffer> <leader>ib :SMLReplBuild<CR>
	" for opening a structure, not a file
	au FileType sml nnoremap <silent> <buffer> <leader>io :SMLReplOpen<CR>
	" use the current file into the REPL (even if using CM)
	au FileType sml nnoremap <silent> <buffer> <leader>iu :SMLReplUse<CR>
	" clear the REPL screen
	au FileType sml nnoremap <silent> <buffer> <leader>ic :SMLReplClear<CR>
	" set the print depth to 100
	au FileType sml nnoremap <silent> <buffer> <leader>ip :SMLReplPrintDepth<CR>

	" ----- Other settings -----

	" Uncomment to try out conceal characters
	" au FileType sml setlocal conceallevel=2

	" Uncomment to try out same-width conceal characters
	" let g:sml_greek_tyvar_show_tick = 1
augroup END



lua << EOF
require('lsp')
require('tree-sitter')
-- Guess Indent
require('guess-indent').setup {}

-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false


-- Gitsigns
require('gitsigns').setup {}

-- Go
require('go').setup {
	auto_lint = false, --use golangci_lint_ls with lsp
	test_popup_auto_leave = true,
	test_popup_width = 100,
}

require('dap-go').setup {}
EOF
