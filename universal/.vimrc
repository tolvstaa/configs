filetype on
syntax enable
set number
set relativenumber
set showmatch
set mouse=a
set backspace=2
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set cindent
colorscheme darkblue
au BufNewFile,BufRead *.rs set filetype=rust
au FileType sh colorscheme delek
au FileType rust colorscheme delek

cnoreabbrev Q q
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev c80 colorcolumn=80
cnoreabbrev noc80 colorcolumn=
