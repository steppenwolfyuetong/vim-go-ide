" Author: yuetong
" Date: 2019-10-28
" Language: Go
"
" =============================================================================
" 处理 Gnome 终端不能使用 alt 快捷键
" 参考：http://landcareweb.com/questions/8623/altjian-kuai-jie-jian-bu-gua-yong-yu-dai-you-vimde-gnomezhong-duan
" ==============================================================================
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50


" ==============================================================================
" vim 内置配置(vim 自身（非插件）快捷键)
" ==============================================================================

" >>  定义快捷键

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $
" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p


" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l

" 定义快捷键在结对符之间跳转
nmap <Leader>M %

" <<

" >> 其他

"让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 关闭兼容模式
set nocompatible

" 开启实时搜索
set incsearch

" 搜索时大小写不敏感
set ignorecase

set number " 设置绝对行号
" set relativenumber " 设置相对行号
set cursorline "突出显示当前行
set cursorcolumn " 突出显示当前列
set showmatch " 显示括号匹配

" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释


syntax enable
syntax on                    " 开启文件类型侦测
filetype plugin indent on    " 启用自动补全

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write

" vim 自身命令行模式智能补全
set wildmenu

" backspace键不能用的问题
set backspace=indent,eol,start

" 保持文件时自动删除尾部的空白字符
autocmd BufWrite * silent! :%s/[[:space:]]\+$//g

" <<


" =======================================================================
" 插件配置
" ========================================================================

" 插件开始的位置 vim-plug 管理的插件列表必须位于 plug#begin('~/.vim/plugged') 和 plug#end() 之间

call plug#begin('~/.vim/plugged')

" Vim 中文文档
Plug 'yianwillis/vimcdoc'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree'

" 可以使 nerdtree Tab标签的名字更友好些
Plug 'jistr/vim-nerdtree-tabs'

" 可以在导航目录中看到 git 版本信息
Plug 'Xuyuanp/nerdtree-git-plugin'

" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" 自动补全括号的插件，包括小括号，中括号，以及花括号
Plug 'jiangmiao/auto-pairs'

" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'

" 有道词典在线翻译
Plug 'ianva/vim-youdao-translater'

" 代码自动完成，安装完插件还需要额外配置才可以使用
Plug 'Valloric/YouCompleteMe'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'


" 下面两个插件要配合使用，可以自动生成代码块
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 可以在 vim 中使用 tab 补全
"Plug 'vim-scripts/SuperTab'

" 可以在 vim 中自动完成
"Plug 'Shougo/neocomplete.vim'


" 配色方案
" colorscheme neodark
Plug 'KeitaNakamura/neodark.vim'
" colorscheme monokai
Plug 'crusoexia/vim-monokai'
" colorscheme github
Plug 'acarapetis/vim-colors-github'
" colorscheme one
Plug 'rakr/vim-one'

" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

" markdown 插件
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

" 自动生成注释的插件
Plug 'scrooloose/nerdcommenter'

" 强大的文件搜索插件
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 格式化代码插件
" 这个插件特定语言需要额外支持， 比如格式化 json， 需要 js-beautify
" 安装可以 yay -S js-beautify(archlinux) 或者 npm install -g js-beautify
" 更多支持参考： https://github.com/Chiel92/vim-autoformat#default-formatprograms
Plug 'Chiel92/vim-autoformat'

" 插件结束的位置，插件全部放在此行上面
call plug#end()


"==============================================================================
" 主题配色
"==============================================================================

" 开启24bit的颜色，开启这个颜色会更漂亮一些
set termguicolors
" 配色方案, 可以从上面插件安装中的选择一个使用
" 主题1
colorscheme one " 主题
set background=dark " 主题背景 dark-深色; light-浅色



"==============================================================================
" vim-go 插件
"==============================================================================
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

let g:godef_split=2

" 直接通过 go run 执行当前文件
autocmd FileType go nmap <leader>r :GoRun %<CR>


"==============================================================================
" NERDTree 插件
"==============================================================================

" 打开和关闭NERDTree快捷键
map <F10> :NERDTreeToggle<CR>
nmap <M-m> :NERDTreeFind<CR>

" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2

" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1


"==============================================================================
"  majutsushi/tagbar 插件
"==============================================================================

" majutsushi/tagbar 插件打开关闭快捷键
nmap <F9> :TagbarToggle<CR>

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }


"==============================================================================
"  nerdtree-git-plugin 插件
"==============================================================================
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeShowIgnoredStatus = 1
nmap <Leader>pwd :NERDTreeCWD<CR>



"==============================================================================
"  Valloric/YouCompleteMe 插件
"==============================================================================

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<M-w>', '<DOWN>']
let g:ycm_key_list_previous_completion = ['<M-d>', '<Up>']
let g:SuperTabDefaultCompletionType = '<M-w>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" 关闭了提示再次触发的快捷键
let g:ycm_key_invoke_completion = '<Leader>,'


"==============================================================================
" UltiSnips 插件
"==============================================================================
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"==============================================================================
"  其他插件配置
"==============================================================================

" markdwon 的快捷键
map <silent> <F5> <Plug>MarkdownPreview
map <silent> <F6> <Plug>StopMarkdownPreview

" tab 标签页切换快捷键
:nn <Leader>1 1gt
:nn <Leader>2 2gt
:nn <Leader>3 3gt
:nn <Leader>4 4gt
:nn <Leader>5 5gt
:nn <Leader>6 6gt
:nn <Leader>7 7gt
:nn <Leader>8 8gt
:nn <Leader>9 8gt
:nn <Leader>0 :tablast<CR>

:nn <M-1> 1gt
:nn <M-2> 2gt
:nn <M-3> 3gt
:nn <M-4> 4gt
:nn <M-5> 5gt
:nn <M-6> 6gt
:nn <M-7> 7gt
:nn <M-8> 8gt
:nn <M-9> 9gt
:nn <M-0> :tablast<CR>

" 自动注释的时候添加空格
let g:NERDSpaceDelims=1

"==============================================================================
" GVim 的配置
"==============================================================================
" 如果不使用 GVim ，可以不用配置下面的配置
if has('gui_running')
    colorscheme one
	" 设置启动时窗口的大小
	set lines=999 columns=999 linespace=4

	" 设置字体及大小
    set guifont=Roboto\ Mono\ 13

	set guioptions-=m " 隐藏菜单栏
	set guioptions-=T " 隐藏工具栏
	set guioptions-=L " 隐藏左侧滚动条
	set guioptions-=r " 隐藏右侧滚动条
	set guioptions-=b " 隐藏底部滚动条

    set guifont=Fira\ Code\ 14
	set lines=999 columns=999
endif


"==============================================================================
" 光标随着插入模式改变形状
" 参考： https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
"==============================================================================
if has("autocmd")
	au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
	au InsertEnter,InsertChange *
		\ if v:insertmode == 'i' |
		\   silent execute '!echo -ne "\e[6 q"' | redraw! |
		\ elseif v:insertmode == 'r' |
		\   silent execute '!echo -ne "\e[4 q"' | redraw! |
		\ endif
	au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

"==============================================================================
" 自定义的额外配置
"==============================================================================
"
" 自动保存 session
autocmd VimLeave * mks! ~/.vim/session.vim
" 加载 session 的快捷键
nmap <Leader>his :source ~/.vim/session.vim<CR>

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-S-i> :Autoformat<CR>

" 有道词典插件
map <M-t> :Ydc<CR>

" 自动切换到当前文件所在的目录 cdpath
map <Leader>cd :cd %:h<CR>
