" basic configuration
set encoding=utf-8
set nu
set ignorecase
set hlsearch
set incsearch
set cursorline
set ruler
set nobackup
set noundofile 
set nocompatible

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup vimStartup
    autocmd!
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
  augroup END
endif

" Put these in an autocmd group, so that we can delete
" them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" setup popup menu color
highlight Pmenu ctermbg=black ctermfg=white
highlight PmenuSel ctermbg=red ctermfg=yellow gui=bold

" set colorcolumn for the source code, such as cpp, c, and python etc.=off
augroup Colorcolumn
  if exists('Colorcolumn')
     autocmd!
  endif
  au BufNewfile,BufRead *.py,*.h,*.cpp,*.cc,*.cu,*.c,*.cxx,*.hpp highlight ColorColumn ctermbg=gray
  au BufNewfile,BufRead *.py,*.h,*.cpp,*.cc,*.cu,*.c,*.cxx,*.hpp set colorcolumn=80
augroup END

" Enable syntax highlighting for tablegen files.
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END


set nocompatible              " be iMproved, required
filetype off                  " required

" close the autocompletation window
autocmd CompleteDone * pclose

call plug#begin('~/.vim/plugged')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" auto completation
Plug 'Valloric/YouCompleteMe', {'branch': 'master'}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'nathanaelkane/vim-indent-guides'

" pytho-mode for python application
Plug 'python-mode/python-mode', { 'branch': 'develop' }

" quoting/parenthesizing mode
Plug 'tpope/vim-surround', {'branch': 'master'}

" vim for latex
Plug 'lervag/vimtex', {'branch': 'master'}

" vim for vimwiki
Plug 'vimwiki/vimwiki', {'branch': 'master'}

" pandoc document
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular', {'branch': 'master'}

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.vim/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" clang-format
Plug 'rhysd/vim-clang-format', {'branch': 'master'}

call plug#end()

let g:plug_window='enew'

" YouCompleteMe
let g:ycm_use_clangd = 0
let g:ycm_show_diagnostics_ui                = 1
let g:ycm_enable_diagnostic_signs            = 0
let g:ycm_enable_diagnostic_highlighting     = 0
let g:ycm_complete_in_strings                = 1
let g:ycm_complete_in_comments               = 1
let g:ycm_min_num_of_chars_for_completion    = 1
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_always_populate_location_list      = 1
let g:ycm_key_invoke_completion              = '<C-o>'
let g:ycm_use_ultisnips_completer            = 1

let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'

" set pymode
let g:pymode_virtualenv = 1
let g:pymode_indent     = 1
let g:pymode_folding    = 0    " disable python-mode folding for speed

let g:pymode_motion   = 1  " enable python-mode motion

let g:pymode_doc      = 1 " enable python-mode documenation
let g:pymode_doc_bind = 'K'

let g:pymode_lint            = 0    " disable python code check for speed
let g:pymode_lint_on_write   = 0
let g:pymode_lint_unmodified = 0
let g:pymode_lint_fly        = 0

" For python project, the semantic code completation is done through ycmd jedi
let g:pymode_rope                      = 0
let g:pymode_rope_completion           = 0
let g:pymode_rope_goto_definition_cmd  = 'e'
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_rename_module_bind   = '<C-c>r1r'


" when to trigger semantic completion
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

" debug for YouCompleteMe
let g:ycm_log_level     = 'debug'
let g:ycm_keep_logfiles = 0

nnoremap <C-j>dd :YcmCompleter GoToDefinition<CR>
nnoremap <C-j>dc :YcmCompleter GoToDeclaration<CR>
nnoremap <C-j>t :YcmCompleter GetType<CR>
nnoremap <C-j>dt :YcmCompleter GetDoc<CR>

" visual mode
vnoremap q <Esc>

" easy align
vmap <Enter> <Plug>(EasyAlign)

" fzf configuration
" Augmenting Ag command using fzf#vim#with_preview function
"    * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"      * For syntax-highlighting, Ruby and any of the following tools are
" required:
"        - Bat: https://github.com/sharkdp/bat
"        - Highlight:
" http://www.andre-simon.de/doku/highlight/en/highlight.php
"        - CodeRay: http://coderay.rubychan.de/
"        - Rouge: https://github.com/jneen/rouge
"
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden','?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(),<bang>0)

" fzf commands
nnoremap <C-j>b :Buffers<CR>
nnoremap <C-j>l :BLines<CR>
