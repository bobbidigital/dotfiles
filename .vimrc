:python import sys;sys.path.append("/Users/jsmith/Library/Python/2.7/lib/python/site-packages")

:syntax on
:set laststatus=2
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
:filetype indent on
:filetype plugin indent on
":set shellcmdflag=-ic
" vimrc file for following the coding standards specified in PEP 7 & 8.
"
"  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab

"Ruby
au BufRead,BufNewFile *.erb,*.rb,*.rake set tabstop=4
au BufRead,BufNewFile *.erb,*.rb,*.rake set shiftwidth=2
au BufRead,BufNewFile *.erb,*.rb,*.rake set expandtab

fu Select_c_style()
    if search('^\t', 'n', 150)
         set shiftwidth=8
	 set noexpandtab
    el 
    	 set shiftwidth=4
	 set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.sh set textwidth=79
au BufRead,BufNewFile *.pp,*.sh set shiftwidth=2 tabstop=2 expandtab

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
"``let python_highlight_all=1``
"``syntax on``

" Automatically indent based on file type: ``filetype indent on``
" Keep indentation level from previous line: ``set autoindent``

" Folding based on indentation: ``set foldmethod=indent``


"" Reselect visual block after shifting

vnoremap < <gv 
vnoremap > >gv
nnoremap <space> za
vnoremap <space> zf

"""""
" Custom AutoCmds
"""""

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"Markdown to HTML
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr> </cr></leader>


""""""
" Fold Levels
"""""
set nofoldenable
set foldmethod=indent
set foldlevel=99



""""""""""
" PyDict settings
""""""""""

filetype plugin on
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 20

nmap <F8> :TagbarToggle<CR>
set number
autocmd FileType html setlocal shiftwidth=2 tabstop=2


python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

function LintFile()
	let l:currentfile = expand('%:p')
	if &ft == 'puppet'
		let l:command = "puppet-lint " . l:currentfile
	elseif &ft == 'eruby.html'
		let l:command = "erb -P -x -T '-' " . l:currentfile . "| ruby -c"
	elseif &ft == 'json'
		let l:command = 'jsonlint -q ' . l:currentfile
	end
	silent !clear
	execute "!" . l:command . " " . bufname("%")
endfunction
map <c-L> :call LintFile()<cr>
execute pathogen#infect()
syntax on
filetype plugin indent on
