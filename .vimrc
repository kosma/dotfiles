" Syntax highlighting
if has("syntax")
    syntax on
    set background=dark
endif

" Various programming aids
if has("autocmd")
    " per-filetype indentation and syntax coloring
    filetype plugin on
    filetype indent on
    " jump to last position (TODO: has problems with window split)
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " per-filetype settings
    autocmd FileType * call AddFileMappings()
endif

" Per-filetype settings
fun AddFileMappings()
    if &ft == "c" || &ft == "cpp"
        imap <F1> #include <.h>ODODOD
        imap <F2> #define 
        imap <F8> #include <stdio.h>int main(int argc, char *argv[], char *envp[]){return 0;}OAOA
    endif
    if &ft == "html" || &ft == "php"
        let PHP_removeCRwhenUnix = 1
        let html_use_css=1
        imap <F8> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    endif
    if &ft == "tex"
        "let tex_fold_enabled = 1
        "set foldmethod=manual
        TTarget pdf
    endif

    if &ft == "perl"
        imap <F8> #!/usr/bin/perluse strict;use warnings;use feature qw(say);use Data::Dumper;use Carp;

        let perl_fold = 1
        "let perl_nofold_packages
        "let perl_nofold_subs

        set matchpairs+=<:>

        " perl-support.vim
        let g:Perl_AuthorName      = 'Kosma Moczek'
        let g:Perl_AuthorRef       = ''
        let g:Perl_Email           = 'kosma@kosma.pl'
        let g:Perl_Company         = ''
    endif

    if &ft == "python" || &ft == "pyrex"
        imap <F8> #!/usr/bin/env python# -*- coding: utf-8 -*-

        set commentstring=" # %s"
    endif
endfun

" Settings that should have been default since 2005.
set showcmd
set showmatch
set incsearch
set hlsearch
set nowrap


" Exit Vim from Midnight Commander.
map <F3> ZQ
map <F4> ZQ

set modeline

" How about we make comments gray and focus on the code instead?
hi SpecialKey ctermfg=DarkGray
hi NonText    ctermfg=DarkGray
hi Comment    ctermfg=DarkGray 

" Don't mess with my xterm title, please.
set notitle

" Enhanced command-line completion.
set wildmenu

" Some vim versions under Cygwin still don't have this by default.
set bs=2

" http://vim.wikia.com/wiki/Highlight_text_beyond_80_columns
"match Todo '\%81v.*'

" Four-space tabs. May break some filetypes - you've been warned.
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
set softtabstop=4
