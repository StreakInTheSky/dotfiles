" Vim Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin(stdpath('data').'/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'simrat39/rust-tools.nvim', { 'for': 'rust' }
Plug 'crispgm/nvim-go'
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'javascript', 'typescriptreact' ] }
Plug 'jez/vim-better-sml', { 'for': 'sml' }
Plug 'kristijanhusak/orgmode.nvim' 
Plug '/usr/local/opt/fzf'
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
"toggles relative number in insert mode
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter	 * set norelativenumber
augroup END

" fzf with Rg
function! RipgrepFzf(query, fullscreen)
	let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
	let initial_command = printf(command_fmt, shellescape(a:query))
	let reload_command = printf(command_fmt, '{q}')
	let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
	call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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

lua <<EOF
-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {}

-- Go
require('go').setup({
	auto_lint = false --use golangci_lint_ls with lsp
})
require('dap-go').setup()

-- Tree-sitter
require('nvim-treesitter.configs').setup({
	ensure_installed = "all", 
	sync_install = false, 
	highlight = {
	enable = true, 
	additional_vim_regex_highlighting = false,
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["a/"] = "@comment.outer",
				["i?"] = "@conditional.inner",
				["a?"] = "@conditional.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["]b"] = "@block.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
				["]B"] = "@block.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[b"] = "@block.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
				["[B"] = "@block.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = 'none',
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
})


-- Langauge Servers & Plugins

-- diagnostics window
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- lsp with nvim-cmp
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
	'eslint',
	'tsserver',
	'clangd',
	'gopls',
	'golangci_lint_ls',
	'html',
	'pyright',
	'racket_langserver',
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		}
end

nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx"},
}

nvim_lsp.denols.setup {
	on_attach = on_attach,
	capabilites = capabilites,
	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
	init_options = { lint = true }
}

-- Enable Rust-tools with nvim-cmp
if vim.bo.filetype == 'rust' then 
	require'rust-tools'.setup({ server = { capablities = capabilities } })
end

-- luasnip setup
local luasnip = require 'luasnip'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert,noselect'

-- nvim-cmp setup
local cmp = require'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
		require('luasnip').lsp_expand(args.body)
	end,
	},
mapping = {
	['<C-p>'] = cmp.mapping.select_prev_item(),
	['<C-n>'] = cmp.mapping.select_next_item(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
		},
	['<Tab>'] = function(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	else
		fallback()
	end
end,
['<S-Tab>'] = function(fallback)
if cmp.visible() then
	cmp.select_prev_item()
elseif luasnip.jumpable(-1) then
	luasnip.jump(-1)
else
	fallback()
end
	end,
	},
sources = {
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' },
	{ name = 'orgmode' },
	},
}

-- Org Mode
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
	-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	highlight = {
	enable = true,
	disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
	additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
	},
  ensure_installed = {'org'}, -- Or run :TSUpdate org
  }

require('orgmode').setup({
org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
org_default_notes_file = '~/Dropbox/org/refile.org',
})
EOF
