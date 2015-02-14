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
Plugin 'jlanzarotta/bufexplorer'
Plugin 'wincent/command-t'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'nanotech/jellybeans.vim'

call vundle#end()               " All plugins must be added before this line
filetype plugin indent on       " load file type plugins + indentation

"" Options
syntax enable
set encoding=utf-8
set showcmd                                              " display incomplete commands
set nojoinspaces                                         " don't add an extra space after a period
autocmd BufRead,BufNewFile *.md setlocal spell           " enable spell checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal textwidth=100   " set text width to 100 characters for markdown files
autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell " enable spell checking for commit messages
set dir=/tmp//                                           " set location for tmp files

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

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Display
set number                      " display line numbers on the left
colorscheme jellybeans

"" Shortcuts
map <silent> <LocalLeader>nh :nohls<CR>

"" ====== Plugin Config ======

" NERDTree
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>


" Requires ruby support in vim
" CommandT
map <silent> <leader>ff :CommandT<CR>
map <silent> <leader>fb :CommandTBuffer<CR>
map <silent> <leader>fr :CommandTFlush<CR>

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
