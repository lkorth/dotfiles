"" Setup
set nocompatible                " choose no compatibility with legacy vi
filetype off

"" Vundle
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'puppetlabs/puppet-syntax-vim'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'ConradIrwin/vim-bracketed-paste'

call vundle#end()               " All plugins must be added before this line
filetype plugin indent on       " load file type plugins + indentation

"" Options
syntax enable
set encoding=utf-8
set showcmd                                              " display incomplete commands
set nojoinspaces                                         " don't add an extra space after a period
set hidden                                               " allow any buffer to be hidden without writing
autocmd BufRead,BufNewFile *.md setlocal spell           " enable spell checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal textwidth=100   " set text width to 100 characters for markdown files
autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell " enable spell checking for commit messages

if ( !exists( "$TMPDIR" ) )                              " set location for tmp files
  set dir=/tmp
else
  set dir=$TMPDIR
endif

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Visual indent keeps block
vnoremap > >gv
vnoremap < <gv

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Display
set number                      " display line numbers on the left

"" Shortcuts
map <silent> <LocalLeader>nh :nohls<CR>
noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <LEFT> <NOP>
noremap <RIGHT> <NOP>

"" ====== Plugin Config ======

" NERDTree
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']

" CtrlP
map <silent> <leader>ff :CtrlP<CR>
map <silent> <leader>fr :CommandTFlush<CR>
map <silent> <leader>be :CtrlPBuffer<CR>
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" TComment
map <silent> <LocalLeader>cc :TComment<CR>

" vim-fugitive
function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction
command! -nargs=0 GitGrepWord :call GitGrepWord()
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'android=java']

" vim-colors-solarized
set background=dark
colorscheme solarized

" syntastic
let g:syntastic_check_on_wq = 1
