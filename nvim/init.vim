" Various GUI/editing options
set nowrap
set ruler
set showmode
set wildmenu

" Hybrid line numbers, used as sign column too
set number
set relativenumber
set signcolumn=number

" Tab/indent settings
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set expandtab
set smarttab
set cino=:0l1g0t0(0

" use system clipboard (bug when selecting multiple lines)
set clipboard+=unnamedplus

" other settings
set nobackup
set noswapfile

set completeopt=preview

set encoding=utf-8
set noerrorbells
set splitbelow
set splitright

" Turn off autohighlight by hitting return
nnoremap <CR> :nohl<CR><CR>

" buffers & tabs
nnoremap <C-Tab> :tabnext<cr>
nnoremap <C-S-Tab> :tabprev<cr>

"set switchbuf=usetab
nnoremap <C-Right> :bnext<cr>
nnoremap <C-Left> :bprevious<cr>

" Quickfix mappings
nmap <F8> :cnext<CR>
nmap <S-F8> :cprevious<CR>

" Window navigation
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Plugins
call plug#begin()

" Themes
Plug 'tomasr/molokai'
Plug 'jnurmine/Zenburn'

" Async make building
Plug 'tpope/vim-dispatch'
"Plug 'neomake/neomake'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Lua status bar + functions + finding the code
" Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
if has("win32")
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
else
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
endif

" parsing the code
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" LSP auto-completion for clangd
Plug 'neovim/nvim-lspconfig'

" move selected code up/down
Plug 'matze/vim-move'

call plug#end()

" Zenburn but change the VertSplit color which by default is terrible
colorscheme zenburn
hi VertSplit guifg=#5b605e guibg=#3f3f3f ctermfg=240 ctermbg=237

let mapleader=","

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" keybinding collision with Fabien's window movement <A-hjkl>
let g:move_key_modifier_visualmode = 'S' 

" Lualine init
lua << LUAEND
require('telescope').setup {
}

require('telescope').load_extension('fzf')

require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "cpp", "make", "cmake", "bash", "sql", "vim", "lua", "markdown" },
	highlight = {
		enable = true
	},
}
LUAEND
