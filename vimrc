" ========================================================================
" Vundle config
" ========================================================================
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/Vundle.vim
  call vundle#begin()

" ========================================================================
" Plugins
" ========================================================================

  Bundle "docteurklein/php-getter-setter.vim"
    autocmd FileType php nnoremap <leader>pg :InsertGetterOnly<cr>
    autocmd FileType php nnoremap <leader>ps :InsertSetterOnly<cr>
    autocmd FileType php nnoremap <leader>pgs :InsertBothGetterSetter<cr>

      let b:phpgetset_setterTemplate =
        \ "\n" .
        \ "    public function %funcname%($%varname%)\n" .
        \ "    {\n" .
        \ "        $this->%varname% = $%varname%;\n" .
        \ "    }"

      let b:phpgetset_getterTemplate =
          \ "\n" .
          \ "    public function %funcname%()\n" .
          \ "    {\n" .
          \ "        return $this->%varname%;\n" .
          \ "    }"

  Bundle "austintaylor/vim-commaobject"
  Bundle "joonty/vdebug"
  Bundle "w0ng/vim-hybrid"
  Bundle "jonathanfilip/vim-lucius"
  Bundle "altercation/vim-colors-solarized"
    let g:solarized_termcolors=256
    " call togglebg#map("<F5>")
  Bundle "mattn/emmet-vim"
  Bundle "othree/html5.vim"
  Bundle "tpope/vim-repeat"
  Bundle "tpope/vim-surround"
  Bundle "wikitopian/hardmode"
    " autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
    nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
  " Bundle "bling/vim-airline"
  "   let g:airline#extensions#tabline#enabled = 1
  "   " let g:airline_powerline_fonts = 1
  "   let g:airline_left_sep = ''
  "   let g:airline_right_sep = ''

  Bundle "airblade/vim-gitgutter"
  Bundle "tpope/vim-fugitive"
    autocmd BufReadPost fugitive://* set bufhidden=delete
    nnoremap <Leader>gac :Gcommit -am ""<LEFT>
    nnoremap <Leader>gc :Gcommit -m ""<LEFT>
    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <leader>gw :Gwrite<cr>
    nnoremap <leader>gb :Gblame<cr>

  Bundle "rking/ag.vim"
    nnoremap g/ :Ag!<space>
    nnoremap g* :Ag! -w <C-R><C-W><space>
    nnoremap ga :AgAdd!<space>
    nnoremap gn :cnext<CR>
    nnoremap gp :cprev<CR>
    nnoremap gq :ccl<CR>
    nnoremap gl :cwindow<CR>

  " snippets
  Bundle "sirver/ultisnips"
  Bundle "mjacobus/vim-snippets"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    let g:snips_author="Marcelo Jacobus <marcelo.jacobus@gmail.com>"

  Bundle "tomtom/tcomment_vim"
  Bundle "Lokaltog/vim-easymotion"
  " Bundle "jiangmiao/auto-pairs"
  Bundle "yukunlin/auto-pairs"
  Bundle "mattn/webapi-vim.git"
  Bundle "mattn/gist-vim.git"
    if has("mac")
      let g:gist_clip_command = 'pbcopy'
    elseif has("unix")
      let g:gist_clip_command = 'xclip -selection clipboard'
    endif

    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 1

  Bundle "scrooloose/nerdtree"
    nnoremap <c-n> :NERDTreeToggle<CR>
    " nmap g :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>

  Bundle "kien/ctrlp.vim"
    " let g:ctrlp_max_height = 30
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
    " let g:ctrlp_working_path_mode = 'c'
    " set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    " set wildignore+='\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn)|data|tmp|log)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

  " Tabular
  Bundle "godlygeek/tabular"
    function! CustomTabularPatterns()
      if exists('g:tabular_loaded')
        AddTabularPattern! symbols / :/l0
        AddTabularPattern! hash /^[^>]*\zs=>/
        AddTabularPattern! chunks / \S\+/l0
        AddTabularPattern! assignment / = /l0
        AddTabularPattern! comma /^[^,]*,/l1
        AddTabularPattern! colon /:\zs /l0
        AddTabularPattern! options_hashes /:\w\+ =>/
      endif
    endfunction

    autocmd VimEnter * call CustomTabularPatterns()

    nnoremap a= :Tabularize /=<CR>
    vnoremap a= :Tabularize /=<CR>
    nnoremap a: :Tabularize /:\zs<CR>
    vnoremap a: :Tabularize /:\zs<CR>
    nnoremap ar :Tabularize /=><CR>
    vnoremap ar :Tabularize /=><CR>

  Bundle "scrooloose/syntastic"
    let g:syntastic_enable_signs=1
    let g:syntastic_quiet_messages = {'level': 'warning'}
    let g:syntastic_php_phpcs_args="--standard=PSR2"
    " syntastic is too slow for haml and sass
    let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': ['haml','scss','sass'] }
  Bundle "weierophinney/argumentrewrap"

  " PHP Plugins
  Bundle "shawncplus/phpcomplete.vim"
  Bundle 'arnaud-lb/vim-php-namespace'
    nnoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
  Bundle 'stephpy/vim-php-cs-fixer'
    let g:php_cs_fixer_level = "psr2"
    let g:php_cs_fixer_fixers_list="-concat_without_spaces"
  Bundle 'joonty/vim-phpqa'
    let g:phpqa_messdetector_ruleset = "~/.dotfiles/php/phpmd_ggs.xml"
    let g:phpqa_codesniffer_args = "--standard=PSR2"

  " Ruby Plugins
  Bundle "vim-scripts/ruby-matchit"
  Bundle "mjacobus/vim-rspec-focus"
  Bundle "vim-ruby/vim-ruby"
  Bundle "tpope/vim-rails"
    nnoremap <leader>av :AV<cr>
    nnoremap <leader>as :AS<cr>
    nnoremap <Leader>va :AV<cr>
    nnoremap <Leader>sa :AS<cr>
    nnoremap <Leader>vc :RVcontroller<cr>
    nnoremap <Leader>sc :RScontroller<cr>
    nnoremap <Leader>vu :RVunittest<CR>
    nnoremap <Leader>su :RSunittest<CR>
    nnoremap <Leader>vv :RVview<cr>
    nnoremap <Leader>sv :RSview<cr>
    nnoremap <Leader>m :Rmodel<cr>
    nnoremap <Leader>sm :RSmodel<cr>
    nnoremap <Leader>vm :RVmodel<cr>

  Bundle "thoughtbot/vim-rspec"
    let g:rspec_command = "!rspec --drb {spec}"
    nnoremap <leader>t :call RunCurrentSpecFile()<CR>
    nnoremap <leader>n :call RunNearestSpec()<CR>
    nnoremap <C-l> :call RunLastSpec()<CR>
    nnoremap <leader>l :call RunLastSpec()<CR>
    nnoremap <Leader>o :w<cr>:call RunCurrentLineInTest()<CR>

  Bundle "shawncplus/Vim-toCterm"
    nnoremap tocterm :source ~/.vim/bundle/Vim-toCterm/tocterm.vim<CR>


  " ending vundle
  call vundle#end()            " required
  filetype plugin indent on    " required
" ========================================================================
" End of Vundle config
" ========================================================================

" ========================================================================
" Options
" ========================================================================
  set background=dark
  " color railscasts256
  " color molokai256
  " color github256
  " color mjdark
  color lucius

  let mapleader = ","
  set pastetoggle=<F3>
  set clipboard=unnamedplus   " use the system clipboard
  set backspace=2             " make backspace work like most other apps
  set nobackup                " no backup. Too 70's
  set noswapfile              " no backup. Too 70's
  set cursorline
  " set relativenumber
  set colorcolumn=80
  set mouse=""                " disable mouse
  set wildmenu
  set foldmethod=syntax
  set foldlevel=1

  " undo per file
  set undodir=~/.vim/undodir
  set undofile
  if filewritable(&undodir) == 0
    call mkdir(&undodir, "p")
  endif

  " required for several plugins
  set nocompatible

  " enable syntax highlighting
  syntax on

  " don't wrap long lines
  set nowrap

  " show commands as we type them
  set showcmd

  " highlight matching brackets
  set showmatch

  " scroll the window when we get near the edge
  set scrolloff=4 sidescrolloff=10

  " use 2 spaces for tabs
  set expandtab tabstop=2 softtabstop=2 shiftwidth=2
  set smarttab

  " enable line numbers, and don't make them any wider than necessary
  set number numberwidth=2

  " show the first match as search strings are typed
  " set incsearch

  " highlight the search matches
  set hlsearch

  " searching is case insensitive when all lowercase
  set ignorecase smartcase

  " assume the /g flag on substitutions to replace all matches in a line
  " set gdefault

  " set temporary directory (don't litter local dir with swp/tmp files)
  set directory=/tmp/

  " pick up external file modifications
  set autoread

  " don't abandon buffers when unloading
  set hidden

  " match indentation of previous line
  set autoindent

  " don't blink the cursor
  set guicursor=a:blinkon0

  " show current line info (current/total)
  set ruler rulerformat=%=%l/%L

  " show status line
  set laststatus=2

  " indicates fast terminal connection
  set ttyfast

  " augment status line
  function! ETry(function, ...)
    if exists('*'.a:function)
      return call(a:function, a:000)
    else
      return ''
    endif
  endfunction
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%{ETry('CapsLockStatusline')}%y%{ETry('rails#statusline')}%{ETry('fugitive#statusline')}%#ErrorMsg#%*%=%-16(\ %l,%c-%v\ %)%P

  " When lines are cropped at the screen bottom, show as much as possible
  set display=lastline

  " flip the default split directions to sane ones
  set splitright
  set splitbelow

  " don't beep for errors
  set visualbell

  " make backspace work in insert mode
  set backspace=indent,eol,start

  " highlight trailing whitespace
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  set list

  " use tab-complete to see a list of possiblities when entering commands
  set wildmode=list:longest,full

  " allow lots of tabs
  set tabpagemax=20

  " remember last position in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

  " Thorfile, Rakefile, Vagrantfile, and Gemfile are Ruby
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

  " hb is handlebars
  au BufNewFile,BufRead *.hb set ai filetype=handlebars

  " hbs is handlebars
  au BufNewFile,BufRead *.hbs set ai filetype=handlebars

  " JSON is JS
  au BufNewFile,BufRead *.json set ai filetype=javascript

  " different color for each paren pairs
  let vimclojure#ParenRainbow = 1



" ========================================================================
" Mappings
" ========================================================================

  " execute jasmine tests
  autocmd FileType javascript nnoremap <buffer> tt :! clear && npm test<cr>

  " tags
  nnoremap <f4> :! ctags <cr> | let tags='tags'

  " escape alias
  inoremap jj <esc>l
  inoremap kj <esc>l

  " navigation
  noremap <space> 10j
  noremap <leader><space> 10k

  " buffer changing
  nnoremap <leader>bn :bn<cr>
  nnoremap <leader>bp :bp<cr>

  " closes buffer
  nnoremap <leader>bd :bd<cr>
  nnoremap <leader>bdd :bd!<cr>
  nnoremap <leader>bda :bufdo %bd!<cr>
  nnoremap <leader>n :NERDTree<cr>

  " saves from normal mode
  nnoremap <leader>s :w<cr>
  nnoremap <leader>S :w<cr>

  " saves and exits insert mode
  inoremap <leader>s <ESC>:w<cr>
  inoremap <leader>S <ESC>:w<cr>

  " Select all
  nnoremap <leader>a ggVG

  " new tab
  nnoremap <c-w>t :tabnew<cr>

  " jumps to the next position after the closest closing char
  inoremap <leader>e <Esc>/[\]})"']<cr><Esc>:nohlsearch<cr>a
  nnoremap <leader>e <Esc>/[\]})"']<cr><Esc>:nohlsearch<cr>a

  " adds arrow
  inoremap <C-l> <Space>=><Space>

  " Ruby old style hashes to new style hashes
  vnoremap <leader>h :s/:\(\w*\) *=>/\1:/g<cr>

  " Rails specific
  " nnoremap <Leader>ac :sp app/controllers/application_controller.rb<cr>
  vnoremap <leader>h :s/\:\([a-zA-Z_]\+\)\s\+=>/\=printf("%s:", submatch(1))/g<CR><ESC>:let @/ = ""<CR>
  nnoremap <Leader>quit <ESC>:q<cr>


  " save and quit Run Ruby, for interactive editor
  nnoremap <Leader>rr <esc>:wq<CR>

  " Open vim rc
  nnoremap <Leader>vim :vsplit $MYVIMRC<CR>
  nnoremap <Leader>rel :source $MYVIMRC<CR>

  " Fix anoying original K
  nnoremap K <nop>
  nnoremap U <nop>
  inoremap <Esc> <nop>

  " Find
  inoremap <leader>f <ESC>/
  nnoremap <leader>f <ESC>/

  " php specific
  autocmd FileType php inoremap ... ../
  autocmd FileType php inoremap .. ->
  autocmd FileType php inoremap ;; <esc>$a;
  " autocmd FileType php set nofoldenable

  " convert file to latin1 and reloads
  nnoremap <leader>lat1 :write ++enc=latin1<cr>:e<cr>

  " Use Q for formatting the current paragraph (or selection)
  vnoremap Q gq
  nnoremap Q gqap

  " clear search
  nnoremap <silent> ,/ :nohlsearch<CR>

  " Avoid arrow keys in command mode
  cnoremap <C-h> <left>
  cnoremap <C-j> <down>
  cnoremap <C-k> <up>
  cnoremap <C-l> <right>
  cnoremap <C-x> <del>

  " Control Ctrl and Ctrl V
  vnoremap <C-c> "+y
  vnoremap <leader>c "+y
  inoremap <C-v> <esc>:set paste<cr>"+p:set nopaste<cr>i
  nnoremap <leader>v :set paste<cr>"+p:set nopaste<cr>i

  " buffer resizing mappings (shift + arrow key)
  nnoremap <Up> <c-w>+
  nnoremap <Down> <c-w>-
  nnoremap <Left> <c-w><
  nnoremap <Right> <c-w>>


  " Trim all trailing whitespaces no questions asked.
  nnoremap <leader>tw :call TrimWhiteSpace()<cr>

  " Tab management
  nnoremap <leader>tn :tabnext<cr>
  nnoremap <leader>tp :tabprev<cr>

  " quotes
  " Single quote word
  nnoremap <leader>sq ciw''<esc><left>p
  " double quote word
  nnoremap <leader>dq ciw""<esc><left>p

  " Execute last command over a visual selection
  vnoremap . :norm.<CR>

  " Resolving conflics
  " Vimcasts #33
  nnoremap <leader>gd :Gdiff<cr>
  " get target version: diff get target
  nnoremap <leader>dgt :diffget //2 \| :diffupdate<cr>
  " get branch version: diff get branch
  nnoremap <leader>dgb :diffget //3 \| :diffupdate<cr>

  " quotes
  nnoremap <leader>qw ciw''<esc>P
  nnoremap <leader>qw ciw""<esc>P

  " sort block
  nnoremap <leader>sb vip:sort<cr>
  nnoremap <leader>sa vi(:sort<cr>

  " wrap selection inside caracter
  vnoremap ( "zdi(<C-R>z)<ESC>
  vnoremap { "zdi{<C-R>z}<ESC>
  vnoremap [ "zdi[<C-R>z]<ESC>
  vnoremap ' "zdi'<C-R>z'<ESC>
  vnoremap " "zdi"<C-R>z"<ESC>

  " does not work right after the plugin
  nnoremap <leader>wa :call argumentrewrap#RewrapArguments()<CR>
" ========================================================================
" Functions
" ========================================================================

  " create directory for the current buffer
  function! <sid>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
      call system('mkdir -p '.shellescape(a:directory))
    endif
  endfunction
  au BufWrite * :call <sid>MkdirsIfNotExists(expand('<afile>:h'))

  " remove trailing white spaces before saving rb files
  function! TrimWhiteSpace()
  " Save cursor position
    let l = line(".")
    let c = col(".")

    %s/\s\+$//e

  " Restore cursor position
    call cursor(l, c)
  endfunction

  function! PHPUnit(args)
    let cmd = "phpunit -c " . fnamemodify('tests/phpunit.xml', ':p') . " " . a:args
    execute "! clear && echo '" . cmd . "' && " . cmd
  endfunction

  function! PHPUnitCurrentFile()
    :call PHPUnit("%")
  endfunction

  function! PHPUnitAll()
    :call PHPUnit("")
  endfunction

  function! PHPUnitFocused()
    :call PHPUnit("--group=focus")
  endfunction

  function! PHPUnitZendModule()
    let module = ZendGetModuleName()
    let cmd = "phpunit -c module/" . module . "/tests/phpunit.xml"
    execute "! clear && echo '" . cmd . "' && " . cmd
  endfunction

  function! ZendGetModuleName()
    return split(split(expand('%'),'module/')[0], '/')[0]
  endfunction

    auto FileType php nnoremap <buffer> tt <esc>:call PHPUnitCurrentFile()<cr>
    auto FileType php nnoremap <buffer> <leader>ta <esc>:call PHPUnitAll()<cr>
    auto FileType php nnoremap <buffer> <leader>tf <esc>:call PHPUnitFocused()<cr>
    auto FileType php nnoremap <buffer> <leader>tm <esc>:call PHPUnitZendModule()<cr>

" ========================================================================
" Abbreviations
" ========================================================================
  ab phpu PHPUnit_Framework_TestCase
  ab funciton function

" ------------------------------------------------------------------------------
" Allow overriding these settings
" ------------------------------------------------------------------------------
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif

" highlight ajustment
  highligh MatchParen cterm=bold ctermbg=none ctermfg=green
