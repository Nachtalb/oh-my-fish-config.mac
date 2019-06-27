"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ==== Install Plugins ====
" This is required for Vundle to work
Plugin 'VundleVim/Vundle.vim'
Plugin 'makerj/vim-pdf'

Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'neoclide/mycomment.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'vimwiki/vimwiki'
Plugin 'ap/vim-buftabline'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'w0rp/ale'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

execute pathogen#infect()

" ==== Ack / Ag ====
" Grep for word under cursor
nnoremap K :Ack -tf "\b<C-R><C-W>\b"<CR>:cw<CR>

" Other settings
let g:ackpreview = 1

" Use silver searcher (ag) if available (much faster than Ack)
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ -U\ --follow

    let g:ackprg='ag --vimgrep --smart-case -U --follow --ignore-dir testreports --ignore SOURCES.txt --ignore-dir var --ignore-dir .idea'
    if isdirectory('parts/omelette/')
        let plone_dir = trim(system('ls -1 -f | grep egg-info | cut -d. -f1'))
        let g:ackprg=g:ackprg . ' --ignore-dir /' . plone_dir
    endif

    nnoremap <Leader>a :Ack <C-r><C-w>
    nnoremap <Leader>A :Ack --ignore-dir tests <C-r><C-w>
endif

" ==== NERDTree ==== "
" Auto show NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Open close with CTRL-E
inoremap <C-e> <ESC>:NERDTreeToggle<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
" Find file in NERDTree with CTRL-F
inoremap <C-f> <ESC>:NERDTreeFind<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Various settins
let NERDTreeWinSize=35
let NERDTreeWinPos = "left"
let NERDTreeRespectWildIgnore = 0
let NERDTreeIgnore = ['\.pyc', '\.pyo', '__pycache__', '\.idea', '\.git', '\.so', '\.swp', 'tmp', '\.DS_Store']
let NERDTreeAutoCenter = 1
let NERDTreeSortHiddenFirst = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1

" ==== Ale ====
let g:ale_fix_on_save = 0
let g:ale_linter_aliases = {'vue': ['vue', 'javascript'],}
let g:ale_fixers = {'python': ['autopep8', 'isort', 'yapf'], 'javascript': ['prettier', 'eslint'],}
let g:ale_linters = {'python': ['flake8'],}

" Use Ale Fixer for these filetypes
au BufNewFile,BufRead *.py,*.js nmap <F8> <Plug>(ale_fix)

" ==== Fugitive ====
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gpl :Git pull -r<cr>
nnoremap <Leader>gpf :Gpush -f
nnoremap <Leader>gpp :Gpush
nnoremap <Leader>gd :Gdiff<cr>
nnoremap <Leader>gcc :Gcommit<cr>
nnoremap <Leader>gca :Git commit --amend --no-edit
nnoremap <Leader>gco :Git checkout
nnoremap <Leader>gcb :Git checkout -b ne/

" ==== buf tabline ====
set hidden
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>
noremap <C-q> :bdelete<CR>

" ==== FZF ====
" Use CTRL-P to launch FZF
execute 'map <C-P> :FZF --inline-info --history=' . expand('~') . '/.fzf_history<CR>'

" ==== VimWiki ====
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
                      \ 'path': '~/wiki',
                      \ 'path_html': '~/wiki/html',
                      \ 'auto_export': 1,
                      \ 'auto_toc': 1,
                    \ },
                    \ {
                      \ 'path': '~/pub_wiki',
                      \ 'path_html': '~/pub_wiki/html',
                      \ 'auto_export': 1,
                      \ 'auto_toc': 1,
                    \ }]
" Auto convert wiki files to HTML
autocmd BufWritePost *.wiki silent VimwikiAll2HTML

" ==== End Plugin Section ====
" This is required for Vundle to work
call vundle#end()
filetype plugin indent on
