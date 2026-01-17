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
nnoremap <C-t> :tabnew<cr>
nnoremap <C-w> :bd!<cr>
"nnoremap <M-w> :tabclose<cr>
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

" File explorer
Plug 'preservim/nerdtree'

" Async make building
Plug 'tpope/vim-dispatch'
"Plug 'neomake/neomake'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Lua status bar + functions + finding the code
" Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" parsing the code
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
" LSP auto-completion for clangd
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'p00f/godbolt.nvim'
Plug 'p00f/clangd_extensions.nvim'

" move blocks of code + one-line formatting
Plug 'matze/vim-move'

" surroounding
Plug 'echasnovski/mini.surround'

"Commeting
Plug 'numToStr/Comment.nvim'

"Remote editing (SSH)
"Plug 'wbthomason/packer.nvim'

" TODO():
" - insert mode: WINDOWS-style copy-pasting
" - disable auto-completion (use with direct call)
" - encoding (for bar & clang-extra-tools AST)

call plug#end()

" Zenburn but change the VertSplit color which by default is terrible
colorscheme zenburn
hi VertSplit guifg=#5b605e guibg=#3f3f3f ctermfg=240 ctermbg=237

let mapleader=","

function! CloseAllBuffersButCurrent()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
noremap  <leader>bd :call CloseAllBuffersButCurrent()<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <M-e> :NERDTreeToggle<CR>
nnoremap <C-`> :terminal<CR>
tnoremap <Esc> <C-\><C-n>

"fast find/replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
"fast search under cursor
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
"insert a single character
nnoremap \ :exec "normal i".nr2char(getchar())."\e"<CR>

" keybinding collision with Fabien's window movement <A-hjkl>
let g:move_key_modifier = 'S' 

" Increases the font size with `amount`
function! Zoom(amount) abort
    call ZoomSet(matchstr(&guifont, '\d\+$') + a:amount)
endfunc

  " Sets the font size to `font_size`
function ZoomSet(font_size) abort
  let &guifont = substitute(&guifont, '\d\+$', a:font_size, '')
endfunc

noremap <silent> <C-+> :call Zoom(v:count1)<CR>
noremap <silent> <C--> :call Zoom(-v:count1)<CR>
noremap <silent> <C-0> :call ZoomSet(11)<CR>

" Lualine init
lua << LUAEND

require('mini.surround').setup()
require('Comment').setup()

require('telescope').setup { }
require('telescope').load_extension('fzf')

-- require('nvim-treesitter.configs').setup {
require('nvim-treesitter.config').setup {
    ensure_installed = { "c", "cpp", "python", "make", "cmake", "bash", "sql", "vim", "lua", "markdown" },
    highlight = {
        enable = true
        },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-n>',
            node_incremental = '<C-n>',
            scope_incremental = '<C-n><cr>',
            node_decremental = '<M-n>',
        },
    },
}

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here

  use {
    'inhesrom/remote-ssh.nvim',
    tag = 'v0.5.1-alpha',
    -- branch = "v0.5.1-alpha",
    requires = {
        "inhesrom/telescope-remote-buffer",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        'neovim/nvim-lspconfig',
    },
    config = function()
        require('telescope-remote-buffer').setup()
 
        -- setup lsp_config here or import from part of neovim config that sets up LSP
 
        -- require('remote-ssh').setup({
        --     on_attach = lsp_config.on_attach,
        --     capabilities = lsp_config.capabilities,
        --     filetype_to_server = lsp_config.filetype_to_server
        -- })
 
        require('remote-ssh').setup({
            -- Optional: Custom on_attach function for LSP clients
            on_attach = function(client, bufnr)
                -- Your LSP keybindings and setup
            end,
        
            -- Optional: Custom capabilities for LSP clients
            capabilities = vim.lsp.protocol.make_client_capabilities(),
        
            -- Custom mapping from filetype to LSP server name
            filetype_to_server = {
                -- Example: Use pylsp for Python (default and recommended)
                python = "pylsp",
                -- More customizations...
            },
        
            -- Custom server configurations
            server_configs = {
                -- Custom config for clangd
                clangd = {
                    filetypes = { "c", "cpp", "objc", "objcpp" },
                    root_patterns = { ".git", "compile_commands.json" },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true
                    }
                },
                -- More server configs...
            },
        
            -- Async write configuration
            async_write_opts = {
                timeout = 30,         -- Timeout in seconds for write operations
                debug = false,        -- Enable debug logging
                log_level = vim.log.levels.INFO,
                autosave = true,      -- Enable automatic saving on text changes (default: true)
                                      -- Set to false to disable auto-save while keeping manual saves (:w) working
                save_debounce_ms = 3000, -- Delay before initiating auto-save to handle rapid editing (default: 3000)
        
                -- Logging configuration
                logging = {
                    max_entries = 1000,      -- Maximum number of log entries to store in memory
                    include_context = true,  -- Include contextual data (URLs, exit codes, etc.) in logs
                    viewer = {
                        height = 15,         -- Height of log viewer split in lines
                        auto_scroll = true,  -- Auto-scroll to bottom when new logs arrive
                        position = "bottom"  -- Position of split (bottom/top)
                    }
                }
            }
        })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


vim.deprecate = (function(overriden)
  return function(_, _, _, xx)
    if xx == 'nvim-lspconfig' then return end
    return overriden(_, _, _, xx)
  end
end)(vim.deprecate)

local opts = { noremap=true, silent=true }
-- vim.keymap.set("n", "<C-+", "<ZoomIn>")
-- vim.keymap.set("n", "<C--", "<ZoomOut>")

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

lspconfig.pylsp.setup {
on_attach = custom_attach,
settings = {
    pylsp = {
    plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
    },
    },
},
flags = {
    debounce_text_changes = 200,
},
capabilities = capabilities,
}

local configs = require("lspconfig.configs")
local nvim_lsp = require("lspconfig")
if not configs.neocmake then
    configs.neocmake = {
        default_config = {
            cmd = { "neocmakelsp", "--stdio" },
            filetypes = { "cmake" },
            root_dir = function(fname)
                return nvim_lsp.util.find_git_ancestor(fname)
            end,
            single_file_support = true,-- suggested
            on_attach = on_attach, -- on_attach is the on_attach function you defined
            init_options = {
                format = {
                    enable = true
                },
                lint = {
                    enable = true
                },
                scan_cmake_in_package = true -- default is true
            }
        }
    }
    nvim_lsp.neocmake.setup({})
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
}

require("clangd_extensions").setup({
    inlay_hints = {
        inline = vim.fn.has("nvim-0.10") == 1,
        -- Options other than `highlight' and `priority' only work
        -- if `inline' is disabled
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refresh of the inlay hints.
        -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = { "CursorHold" },
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
        -- The highlight group priority for extmark
        priority = 100,
    },
    ast = {
        -- These are unicode, should be available in any font
        role_icons = {
            type = "🄣",
            declaration = "🄓",
            expression = "🄔",
            statement = ";",
            specifier = "🄢",
            ["template argument"] = "🆃",
        },
        kind_icons = {
            Compound = "🄲",
            Recovery = "🅁",
            TranslationUnit = "🅄",
            PackExpansion = "🄿",
            TemplateTypeParm = "🅃",
            TemplateTemplateParm = "🅃",
            TemplateParamObject = "🅃",
        },
        --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

        highlights = {
            detail = "Comment",
        },
    },
    memory_usage = {
        border = "none",
    },
    symbol_info = {
        border = "none",
    },
})

LUAEND
