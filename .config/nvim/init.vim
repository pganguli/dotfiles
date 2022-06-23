if &compatible " only if not set before:
    set nocompatible " not compatible with vi
endif

filetype on " turn on filetype detection
syntax on " turn on syntax highlighting
filetype plugin on " load file-type specific plugin files
filetype indent on " load file-type specific indent files
" take cursor to first line, reformat till last line
nnoremap ,i gg=G

set ruler " show position in status bar
set matchpairs+=<:> " match <:> too
set wildmode=longest:full,full " bash like tab-completion
set completeopt=longest,menu,preview " bash like ctrl-[np] completion
set title " show filename
set encoding=utf-8 " set text encoding to utf-8
set history=10000 " more history
set updatetime=1000 " write to swap file if idle for 1s
set shortmess+=I " disable startup message
set confirm " get dialog when buffer save fails
set lazyredraw " do not redraw without interaction
set laststatus=2 " always show status line
set autochdir " set current directory to directory of last opened file
set hidden " allow hidden buffers (not displayed in any window)
set mouse=nvi " pass mouse input to vim, but not in command mode
set signcolumn=no " never show sign column
set cursorline " highlight current line
" toggle cursor line
nnoremap ,c :set cursorline!<CR>

" ------------------------------------------------------------------
" Set status line
" ------------------------------------------------------------------
" %< truncate-at-start if too long
"   %f path to file in buffer
"     \_ blank space
"        %m modified flag
"          %r readonly flag
"            %= equal-space section alignment
"              %B\_ value of character under cursor in hex
"                  %y file type in Vim
"                    [%{&fileencoding}] file encoding format in Vim
"                       [%{&fileformat}] line ending format in Vim
"                          %-14. left-justify-item with minwidth=14.maxwidth=inf
"                               (%l,%c%V%) line-number,column-number,virtual-column-number
"                                         \ %P\ %L percentage-through-file total-lines
set statusline=%<%f\ %m%r%=%B\ %y[%{&fileencoding}][%{&fileformat}]\ %-14.(%l,%c%V%)\ %P\ %L
" ------------------------------------------------------------------

" ------------------------------------------------------------------
" Set Colors
" ------------------------------------------------------------------
if (has("termguicolors")) " if available:
    set termguicolors " use Truecolor
endif

colorscheme slate " set color palette

" link ugly color groups to saner ones
highlight! link Pmenu Folded
highlight! link PreProc Include
" tweak some other groups
highlight! CursorLine guibg=grey15
highlight! Normal guibg=black
highlight! NonText guibg=black
highlight! Comment guifg=grey60
highlight! LineNr guifg=grey60
" ------------------------------------------------------------------

set autoindent " copy indent from current line to new line
set smartindent " indent after brackets and more
set shiftwidth=4 " 4 spaces for each indent
set softtabstop=4 " tabs are displayed as 4 spaces on screen
set tabstop=4 " tabs are expanded to 4 spaces in the file
set expandtab " expand tabs to spaces
" indent visual selection with tab
vnoremap <Tab> >
vnoremap <S-Tab> <

" always yank to system clipboard
set clipboard=unnamedplus

set scrolloff=5 " show 5 lines above and below cursor (when possible)
set nowrap " do not wrap long lines
" toggle wrapping of long lines
nnoremap ,w :set wrap!<CR>
set backspace=indent,eol,start " allow backspacing over everything
" tabs, trailing spaces, leading chars, trailing chars, non-breakable spaces
set listchars=tab:›\ ,trail:␣,precedes:«,extends:»,nbsp:⍽
set list " show listchars
" toggle displaying of listchars
nnoremap ,l :set list!<CR>
set number " line numbering
" toggle relative numbering
nnoremap ,n :set relativenumber!<CR>

set incsearch " search as you type
set ignorecase " ignore case for searching
set smartcase " override ignore case when upper case letters are present
set hlsearch " highlight search
" toggle search highlighting
nnoremap ,h :set hlsearch!<CR>

" toggle spellchecking
nnoremap ,s :set spell!<CR>
" use internal spellfile as dictionary if spellchecking is on
set dictionary+=spell
" use the dictionary for autocomplete
set complete+=k

" list buffers and offer to change
nnoremap ,b :buffers<CR>:buffer<Space>
set splitright " open new split panes to right
set splitbelow " open new split panes to bottom
" move cursor to previous window
nnoremap <Space> <C-w>p
" move between buffers with Alt+Arrow
nnoremap <M-Left> :bprevious<CR>
nnoremap <M-Right> :bnext<CR>
nnoremap <M-Up> :bfirst<CR>
nnoremap <M-Down> :blast<CR>
" Page-Up and Page-Down
nnoremap <C-k> <C-b>
nnoremap <C-j> <C-f>

" autowrite files before commands like `make`
set autowrite
" make command to execute if `Makefile` is absent
set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ make\ $*\ '%<';fi
nnoremap ,m :make<CR>
" open terminal in vertical split
nnoremap ,t :vsplit <Bar> terminal<CR>
" run executable with same name as source file
nnoremap ,r :terminal ./'%<'<CR>
" do not print page numbers
set printheader=%<%f%h%m%=
" font size for printing
set printfont=courier:h14
" print to PS
nnoremap ,p :hardcopy > %.ps<CR>

" load GDB plugin and start it, putting source window on right
nnoremap ,d :packadd termdebug<CR>:Termdebug %<<CR><C-w>k<C-w>k<C-w>L
nmap <leader>b :Break<CR>
nmap <leader>r :Run<CR>

" behave like `[t]ail -[f]`
nnoremap <leader>tf :set autoread <Bar> au CursorHold * checktime <Bar> call feedkeys("lh")<CR>

" load man plugin
runtime! ftplugin/man.vim

" load fzf plugin
set rtp+=/usr/share/doc/fzf/examples/

" netrw config
let g:netrw_liststyle=3 " tree style listing
let g:netrw_banner=0 " suppress top banner
let g:netrw_browse_split=3 " open file in new tab
let g:netrw_browse_split=4 " open file in previous window
let g:netrw_winsize=20 " set netrw window size
let g:netrw_keepdir=0 " sync netrw $PWD with vim

" ------------------------------------------------------------------
" coc config
" ------------------------------------------------------------------
" Notify coc.nvim to format on <CR>
inoremap <silent> <expr> <CR> pumvisible() ? "\<CR>" :
                            \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" use <Tab> for trigger completion with characters ahead and navigate
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" :
                  \ <SID>check_back_space() ? "\<Tab>" : coc#refresh()
" use <S-Tab> to navigate backwards if completion menu is visible,
" else insert literal <Tab>
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-v>\<Tab>"
" let <Up> and <Down> naviagate same as without completion menu
inoremap <expr> <Up> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
inoremap <expr> <Down> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"

" check if previous character is whitespace
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap gk :call CocActionAsync('doHover')<CR>
" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" ------------------------------------------------------------------

" ------------------------------------------------------------------
" Use local perl to handle substitution
" ------------------------------------------------------------------
" Invoke via :S/pattern/replace/flags
function s:Substitute(line1, line2, sstring)
  let l:lines=getline(a:line1, a:line2)
  " Call perl using utf8.  #line etc makes error messages prettier
  let l:sysresult=system("perl -e 'use utf8;' -e '#line 1 \"perl substitution\"' -pe ".
        \shellescape("s".escape(a:sstring,"%!").";"), l:lines)
  if v:shell_error
    echo l:sysresult
    return
  endif
  let l:result=split(l:sysresult, "\n", 1)  " 1: don't drop blank lines
  " delete lines but don't put in register:
  execute a:line1.",".a:line2." normal \"_dd"
  call append(a:line1-1, l:result)  " add lines
  call cursor(a:line1, 1)  " back to starting place
  if a:line1 == a:line2
    echom "Substitution on line" a:line1
  else
    echom "Substitution on lines" a:line1 "to" a:line2
  endif
endfunction

command -range -nargs=1 S call s:Substitute(<line1>, <line2>, <q-args>)
" ------------------------------------------------------------------

" handle w -> W typo
command -nargs=0 W :wall

" handle q -> Q typo
command -nargs=0 Q :qall

" handle wq -> Wq typo
command -nargs=0 Wq :wq

" write de-duplicated file, preserving order of lines
command -nargs=0 Rdupe :%!awk '\!visited[$0]++'

" write file with DOS line endings
command -nargs=? -complete=file Dosw :w ++ff=dos <args>

" write file with Unix line endings
command -nargs=? -complete=file Unixw :w ++ff=unix <args>

" sudo write file
command -nargs=0 Sudow :write !SUDO_ASKPASS='/usr/libexec/openssh/x11-ssh-askpass' sudo --askpass tee % >/dev/null

" remove trailing spaces and tabs
command -nargs=0 Rtrail :%s/\s\+$//g

" open terminal in horizontal split
command -nargs=0 Ster :split|:terminal

" open terminal in vertical split
command -nargs=0 Vter :vsplit|:terminal

" highlight repeated lines
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% Dupes <line1>,<line2>call HighlightRepeats()

" subtract a file from current buffer
command -nargs=1 -complete=file Subtract :%!grep -vxFf <args>

" Set up persistent undo across all files
set undofile
