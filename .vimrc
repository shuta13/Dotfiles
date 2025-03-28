syntax enable

set fenc=utf-8

set enc=utf-8

" language en_US
" ↑だと絵文字や漢字のコピーができない
lang en_US.UTF-8

set number

set noswapfile

inoremap <silent> jj <ESC>

"inoremap <silent> :: <ESC>

inoremap <silent> :q1 <:q!>

set autoindent

set smartindent

set nowrap

set nobackup

set nocompatible

set expandtab

set tabstop=2

set shiftwidth=2

set hidden

set nowrap

set incsearch

set number

set showmatch

set smarttab

set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set whichwrap=b,s,<,>,[,]

set directory=~/.vim/tmp

au BufNewFile,BufRead *.pde setf processing
au BufNewFile,BufRead *.vue setlocal filetype=vue.html.javascript.css

if has('mouse')
  set mouse=a
endif

" Yank -> Clipboard
set clipboard+=unnamed

" 起動画面を出さない
set shortmess+=I

" undoの永続化
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" vimgrepのignore
" @see https://vi.stackexchange.com/questions/18899/exclude-folder-when-searching-files-in-working-directory
set wildignore=*/node_modules/*

" deinの設定
" @see https://github.com/Shougo/dein.vim
if &compatible
  set nocompatible " Be iMproved
endif

" VisualモードでPasteした際にBufferを更新しないように
" @see https://vi.stackexchange.com/questions/25259/clipboard-is-reset-after-first-paste-in-visual-mode
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" Required:
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" Required:
call dein#begin('~/.cache/dein')

" Let dein manage dein
call dein#add('~/.cache/dein')
call dein#add('roxma/nvim-yarp')
call dein#add('roxma/vim-hug-neovim-rpc')
" neovim では ~/.vim/colors に iceberg.vim を移動させないと適用されなさそう。
call dein#add('cocopon/iceberg.vim')
if has('nvim')
  call dein#add('lambdalisue/fern.vim')
  call dein#add('lambdalisue/fern-git-status.vim')
  call dein#add('lambdalisue/fern-renderer-nerdfont.vim')
  call dein#add('lambdalisue/nerdfont.vim')
  call dein#add('lambdalisue/glyph-palette.vim')
else 
  call dein#add('preservim/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
endif
call dein#add('jiangmiao/auto-pairs')
call dein#add('neoclide/coc.nvim', {'build': 'coc#util#install()'})
call dein#add('tpope/vim-fugitive')
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
				\ 'build': 'sh -c "cd app && yarn install"' })
call dein#add('christoomey/vim-conflicted')
call dein#add('luochen1990/rainbow')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('airblade/vim-gitgutter')
call dein#add('APZelos/blamer.nvim')
call dein#add('github/copilot.vim')
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim', { 'rev': '0.1.8' })
call dein#add('nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' })
" call dein#add('prettier/vim-prettier', {'build': 'npm install'})
call dein#add('sbdchd/neoformat')

" cocのコードジャンプ系のキーバインド設定
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" C-o ... back jump: https://github.com/neoclide/coc.nvim/issues/3044
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" https://dev.to/casonadams/neovim-auto-select-suggestions-using-coc-vim-3enk
" --------------------------------------------------------
" COC-VIM TAB SETTINGS START

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" COC-VIM TAB SETTINGS END
" --------------------------------------------------------

" GoTo code navigation.
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <C-t> <Plug>(coc-references)

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif


if has('nvim')
  " fern(vimだと正常に動かない可能性あり)
  augroup my-fern-startup
    autocmd! *
    autocmd VimEnter * ++nested Fern %:h -drawer -right -width=45
  augroup END
  nmap <silent> <C-b> :Fern %:h -drawer -toggle -right -width=45<CR>
  " ドットファイルを表示する。
  let g:fern#default_hidden=1
  " https://github.com/lambdalisue/fern.vim/wiki/Tips#how-to-customize-fern-buffer
  function! s:init_fern() abort
    " https://github.com/lambdalisue/fern.vim/wiki/Tips#perform-expand-or-collapse-directory
    nmap <buffer><expr>
        \ <Plug>(fern-my-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-collapse)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
    nmap <buffer><nowait> o <Plug>(fern-my-expand-or-collapse)
    " nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)
    " --------------------------------------------------------
    " Define NERDTree like mappings
    " https://github.com/lambdalisue/fern.vim/wiki/Tips#define-nerdtree-like-mappings
    " nmap <buffer> o <Plug>(fern-action-open:edit)
    nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
    nmap <buffer> t <Plug>(fern-action-open:tabedit)
    nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
    nmap <buffer> i <Plug>(fern-action-open:split)
    nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
    nmap <buffer> s <Plug>(fern-action-open:vsplit)
    nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p
    nmap <buffer> ma <Plug>(fern-action-new-path)
    nmap <buffer> P gg
    nmap <buffer> C <Plug>(fern-action-enter)
    nmap <buffer> u <Plug>(fern-action-leave)
    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>
    nmap <buffer> cd <Plug>(fern-action-cd)
    nmap <buffer> CD gg<Plug>(fern-action-cd)<C-o>
    nmap <buffer> I <Plug>(fern-action-hidden-toggle)
    nmap <buffer> q :<C-u>quit<CR>
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END
  " nerdfont
  " explorerのアイコン。SauceCodePro Nerd Font ダウンロードする
  let g:fern#renderer = "nerdfont"
  " glyph-palette
  " アイコンに色つける
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
else
  " nerdtree
  autocmd VimEnter * NERDTree | wincmd p
  " https://github.com/preservim/nerdtree/wiki/F.A.Q.#how-do-i-show-hidden-files
  let NERDTreeShowHidden=1
  " https://stackoverflow.com/questions/5116344/how-to-make-nerdtree-always-open-on-the-right-side
  let g:NERDTreeWinPos = 'right' 
  nmap <silent> <C-b> :NERDTreeToggle<CR>
endif

" 外観モードと背景色をあわせる
" from: https://github.com/fatih/dotfiles/blob/ca3dfe3dbacd00e56f32f321e4acbf7075a77bde/vimrc#L121-L138
" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! ChangeBackground()
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark   " for dark version of theme
  else
    set background=light  " for light version of theme
  endif
  colorscheme iceberg

  try
    execute "AirlineRefresh"
  catch
  endtry
endfunction
" initialize the colorscheme for the first run
call ChangeBackground()

" Silent `redrawtime exceeded`
" https://dev.to/ronenlaufer/comment/1d702
set re=0

" markdown-preview-nvim
nmap <silent> <C-s> <Plug>MarkdownPreview
nmap <silent> <M-s> <Plug>MarkdownPreviewStop
nmap <silent> <C-p> <Plug>MarkdownPreviewToggle

" vim-conflicted
let g:diffget_local_map = 'gl'
let g:diffget_upstream_map = 'gu'

" rainbow(bracket pair colorizer)
" It doesnt work with JSX/TSX
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
" term color : https://h2plus.biz/hiromitsu/entry/674
function! ChangeIndentColor()
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
  else
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=7
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=247
  endif
endfunction
" initialize the colorscheme for the first run
call ChangeIndentColor()

" coc-prettier
" " enabled after executing CocInstall coc-prettier
" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
" autocmd BufWritePre *.*js* call CocAction('runCommand', 'prettier.formatFile')
" autocmd BufWritePre *.*ts* call CocAction('runCommand', 'prettier.formatFile')
" autocmd BufWritePre *.html call CocAction('runCommand', 'prettier.formatFile')
" autocmd BufWritePre *.md call CocAction('runCommand', 'prettier.formatFile')
" autocmd BufWritePre *.*css call CocAction('runCommand', 'prettier.formatFile')
" autocmd BufWritePre *.astro call CocAction('runCommand', 'prettier.formatFile')
" " nmap <silent> <C-p> <Plug>Prettier

" vim-prettier
" https://github.com/prettier/vim-prettier/issues/191#issuecomment-614280489
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_require_pragma = 0
" let g:prettier#autoformat_configurations = {
"       \ 'markdown': { 'parser': 'markdown' },
"       \ }
" autocmd BufWritePre *.md PrettierAsync

" neoformat
let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.*js* Neoformat
autocmd BufWritePre *.*ts* Neoformat
autocmd BufWritePre *.html Neoformat
autocmd BufWritePre *.md Neoformat
autocmd BufWritePre *.*css Neoformat
autocmd BufWritePre *.astro Neoformat

" coc-eslint: formatters save integration
autocmd BufWritePre *.*js* call CocAction('runCommand', 'eslint.executeAutofix')
autocmd BufWritePre *.*ts* call CocAction('runCommand', 'eslint.executeAutofix')
autocmd BufWritePre *.vue call CocAction('runCommand', 'eslint.executeAutofix')
autocmd BufWritePre *.astro call CocAction('runCommand', 'eslint.executeAutofix')

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" blamer.nvim
let g:blamer_show_in_insert_mode = 0
let g:blamer_show_in_visual_modes = 0
" nmap <silent> <C-S-b> :BlamerToggle<CR>

" copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)

" telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" buffer操作向けkeymap
nnoremap <silent> <C-h> :bprev<CR>
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-d> :bd<CR>
