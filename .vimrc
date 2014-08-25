""""""""""""""""""""""""""""""""""""""""""""""
"
"  Language:     Vim 7.0+ vimrc script 	
"  Maintainer:	 zhufeng  < Iwantcomputer@gmail.com >
"  Last Change:	 2014-07-20 01:25:41
"  Version:		 1.5.6
"  Remark:       vimrc, vim配置文件
"  License:      This file is placed in the public domain.
"
"  本文件适用于: 
"				Vim/Gvim/MacVim 
"				Windows/Linux/Unix/Mac
"				GUI/Shell/Console
"
"  Tips: 
"	  1.在Windows平台下使用此_vimrc文件时，请用vim打开它，
"	    并设置 :set ff=dos 和 :set fenc=cp936，回车并保存并重启vim。
"
"	    When using this vimrc file in Windows, please set 
"	    :set ff=dos and :set fenc=cp936, then save it and restart vim.
"
"	  2.在非Windows平台(Linux/Unix/Mac OS X)下使用时，
"		设置 :set ff=unix 和 :set fenc=utf8，回车并保存并重启vim。
"	    此项设置为修正此vimrc文件编码使vim正常工作。
"
"	    When using this vimrc file in Linux/Unix/Mac OS X, please set 
"	    :set ff=unix and :set fenc=utf8, then save it and restart vim.
"
"	  3.此vimrc文件在Windws 7 x64平台上使用gvim x86/x64通过使用测试，
"	    同时在RHEL/LMDE/Ubuntu x64的vim/gvim，IBM AIX的自编译vim7.3，
"	    以及Mac OS X Lion/Mavericks的vim, MacVim 通过基本测试。
"	    若发现bug欢迎邮件联系。
"
"	  4.关于各不同平台vimrc文件存放位置，参考 :help vimrc。
"
"	  5.本文件中<Leader>全部使用<L>代替
"
"	  6.当前版本此文件行数：473行
"
""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""
" => 通用全局相关配置
""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " 关闭 vi 兼容模式

" 映射<Leader>为英文逗号
let mapleader = ","
let g:mapleader = ","

set number " 显示行号
set cursorline " 高亮显示当前行
set ruler " 打开状态栏标尺
" 当缓冲区被放弃 (abandon) 时不卸载之
set hidden 

"设置界面超简洁模式，无菜单，工具栏，无所有滚动条
"采用vim样式标签栏而不用系统gui式标签栏，以免白色刺眼
"设置回默认的显示方式，可用:set go=egmLrtT
set guioptions=
"set guioptions-=T " 隐藏工具栏
"set guioptions-=m " 隐藏菜单栏
set showcmd   " 在屏幕最后一行显示未输入完成的命令

set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 总是显示状态栏 
" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\%0(%{&fileformat}\ %{&encoding}\:%{&fileencoding}\ [%c%V:%l/%L-%p%%]%)
"设置tab栏显示的信息
"set tabline=%{tabpagenr()}.%t\ %m
set guitablabel=[%{tabpagenr()}]\ %t\ %m

" 各种文件格式omni自动补全
if has("autocmd")
	autocmd FileType c set omnifunc=ccomplete#Complete
	autocmd FileType cpp set omnifunc=cppcomplete#Complete
	autocmd Filetype java set omnifunc=javacomplete#Complete
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
endif

set completefunc=javacomplete#CompleteParamsInfo
" inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
" inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

"以下几行是设置中文及多编码文件支持
let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1


""""""""""""""""""""""""""""""""""""""""""""""
" => 设置字体及语法高亮颜色(全平台全版本通用)
""""""""""""""""""""""""""""""""""""""""""""""
syntax on " 开启自动语法高亮

if has("gui_running")  "若以gvim(带GUI)形式运行

	if has("gui_macvim") || has("mac")  "Mac平台的设置
		set lazyredraw  "启用延迟重绘
		"设置窗口的大小
		"set lines=46
		"set columns=157
		set transparency=20  "MacVim自带透明功能，0-100之间
		set guifont=Monaco:h16 "设置字体
		"set guifont=dejaVu\ Sans\ MONO:h16  "设置字体
		colorscheme molokai  "设置配色方案
		"colorscheme desert  
		"colorscheme slate 
		set go=TRrgme "设置MacVim专有的漂亮工具栏及右滚动条

		"因mac也属于unix，故要先判断系统是否MacOS,
		"不是mac之后再用elseif判断是否unix
		"否则Mac平台设置会被unix平台设置所覆盖不会生效
	elseif has("unix")  "Linux, Unix平台的设置
		"因linux字体名称不一，安装的字体也不一，故有几个可选 
		"若不好看，可用:set gfn=* 弹出字体选择框手动重选
		set guifont=Monospace\ 13
		"set guifont=Monaco\ 15
		"set guifont=Bitstream\ Vera\ Sans\ Mono\ 15
		"set guifont=Luxi\ Mono\ 15
		"set guifont=DejaVu\ sans\ mono\ 15
		colorscheme molokai  "设置配色方案
		"colorscheme desert
		"colorscheme slate
		set go=e  "隐藏菜单栏/工具栏/左右滚动条

		"解决Linux gvim菜单乱码  
		set langmenu=zh_CN.UTF-8
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
		language messages zh_CN.utf-8 
	endif

	if has("win32") "Windows平台的设置
		set guifont=Consolas:h14   "字体设置
		colorscheme molokai   "设置配色方案
		"colorscheme zenburn
		"colorscheme desert
	endif

	"以无gui方式即shell下运行vim时的颜色，
	"因shell下无法调整字体，故不需设置字体
else
	colorscheme desert
	"colorscheme evening
	"colorscheme peachpuff
	"colorscheme slate
	"colorscheme solarized
endif

"设置光标在输入法IME关闭时显示浅蓝色，而在开启时显示绿色。
"以上设置只在Normal模式下才有用，而且有时也不准，
"而在Insert模式下都是显示CursorIM的设置，也就是绿色
"注意，在切换了syntax状态和coloscheme之后该设置可能会失效
if has("multi_byte_ime")
	highlight Cursor guibg=LightBlue guifg=NONE
	highlight CursorIM guibg=Green guifg=NONE
endif


""""""""""""""""""""""""""""""""""""""""""""""
" => 操作及行为相关配置
""""""""""""""""""""""""""""""""""""""""""""""
set history=800  "设置历史步数
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set autochdir " 自动切换当前目录为当前文件所在的目录
set wrap  "设置自动换行
set linebreak "设置自动换行时把断开的单词显示到下一行
set backupcopy=yes " 设置备份时的行为为覆盖

" 搜索时忽略大小写，但在有一个或以上大写字母时仍区分大小写
set ignorecase smartcase 
set wrapscan " 在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本

set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码

" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set autoread  "当文件在外部被修改，自动更新该文件
set wildmenu  "开启增强型命令行补全

"关闭自动备份和swap交换文件
set nobackup
set nowritebackup
set noswapfile


""""""""""""""""""""""""""""""""""""""""""""""
" =>源代码语法缩进折叠相关配置
""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on " 开启文件类型判断插件
set foldenable " 开启折叠
set foldmethod=syntax " 设置折叠方式为按语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" set foldclose=all " 设置为自动关闭折叠
set smartindent " 开启新行时使用智能自动缩进
"设定退格键可在自动缩进，换行符和插入开始的位置上退格
set backspace=indent,eol,start  
set cindent shiftwidth=4    "设置C语言的自动缩进为4个空格

" 显示Tab符
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
if has("autocmd")
	autocmd filetype javascript,php,python set list
endif


""""""""""""""""""""""""""""""""""""""""""""""
" =>按键映射及插件专有设置
""""""""""""""""""""""""""""""""""""""""""""""

" 映射Windows版gVim窗口透明度控制
if has("win32")
	" 启动时默认透明度为225
	autocmd GUIEnter * call libcallnr("vimtweak.dll","SetAlpha",225)
	" 取Transparent透明单词的首字母，分为a-d透明度越来越低
	map <leader>ta :call libcallnr("vimtweak.dll","SetAlpha",150)<CR>
	map <leader>tb :call libcallnr("vimtweak.dll","SetAlpha",180)<CR>
	map <leader>tc :call libcallnr("vimtweak.dll","SetAlpha",200)<CR>
	map <leader>td :call libcallnr("vimtweak.dll","SetAlpha",225)<CR>
	map <leader>t  :call libcallnr("vimtweak.dll","SetAlpha",255)<CR>
endif

"F2键使用ctags自动生成当前目录及子目录下所有源文件的tags，
"生成所有源文件的tag文件名称为ectags，以方便清理这些tag文件
"生成好之后设置vim的目标tags文件为当前目录下刚自动生成的ectags文件
map <F2> :silent !ctags -R -f ectags *.*<CR>:set tags=ectags<CR>

"Ctrl+F2打开新标签页编辑_vimrc文件
nmap <C-F2> :tabnew $MYVIMRC<CR>

"F12键删除所有行未尾空格
nmap <F12> :%s,\s\+$,,g<CR>

"上下方向键可在由长行分割成的多行短行间上下移动
nmap <Up> gk
nmap <Down> gj

"可视模式下使用Ctrl-C复制，Ctrl-X剪切，Ctrl-V粘贴，
vmap <C-c> "+y
vmap <C-x> "+x
vmap <C-v> "+gP

" 在输入模式下移动光标，彻底抛弃方向键
inoremap <C-h> <left>
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
inoremap <C-l> <Right>
"inoremap <M-h> <C-o>b
"inoremap <M-l> <C-o>w
inoremap <C-a> <Home>
inoremap <C-e> <End>

"窗口分割后,切换窗口需要按<ctrl-w> + 方向,
"现映射为直接按ctrl+方向
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 在文件最后一行自动加入模式行, 调用方式为<L>ml
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"设置映射ctrl+F5编译运行当前打开的程序源文件
"调用自定义的函数来实现该功能
map <C-F5> :call CompileRun() <CR>

"定义CompileRun函数，用来调用进行编译和运行程序源文件
function! CompileRun()
	"编译执行前先调用 :wa 保存所有源文件
	exec "wa"
	let emptyerrorlist = []
	"下面部分的写法说明及规则：
	" 先判断是哪种程序源文件，再用:compiler xx为相应编译器设定相关选项
	" 然后设定makeprg调用外部编译器命令，再用:silent make编译
	" 再用相应命令运行编译得的程序，最后用:cw命令自动选择显示quickfix
	" exec后面表示在vim里用:执行，以!开头代表在shell里执行的命令
	" %表示当前文件的文件名 %<表示当前文件名不带扩展名
	" win下建议用&&多条命令在同一个cmd窗口里执行，同时可灵活使用cls清屏
	if &filetype == 'c'
		"c程序
		"下面的c++文件原理是一样的
		exec "compiler gcc"
		if has("win32")
			set makeprg=gcc\ %\ -o\ %<.exe
			exec "silent make"
			if (getqflist() == emptyerrorlist)
				exec "!%<.exe"
			endif
		else
			set makeprg=gcc\ %\ -o\ %<.out
			exec "silent make"
			if (getqflist() == emptyerrorlist)     
				exec "!.\/%:r.out"
			endif
		endif
		exec "cw"

		"c++程序 
	elseif &filetype == 'cpp'     
		exec "compiler gcc"
		if has("win32")
			set makeprg=g++\ %\ -o\ %<.exe
			exec "silent make"
			if (getqflist() == emptyerrorlist)
				exec "!%<.exe"
			endif
		else
			set makeprg=g++\ %\ -o\ %<.out
			exec "silent make"
			if (getqflist() == emptyerrorlist)     
				exec "!.\/%:r.out"
			endif
		endif
		exec "cw"       

		"Java程序
		"原理跟上面一样，先删除 当前文件名.class，再设定:compiler
		"然后设定makeprg使用javac编译，再java执行程序 
	elseif &filetype == 'java'
		exec "compiler javac"
		set makeprg=javac\ %
		exec "silent make"
		if (getqflist() == emptyerrorlist)
			exec "!java %<"
		endif          
		exec "cw"

		"Perl程序
		"perl -W表示开启所有编译器警告提示
	elseif &filetype == 'perl'
		if has("win32")
			exec "!cls && perl -W %<.pl"
		else
			exec "!perl -W %<.pl"
		endif
		exec "cw"

		"LaTex文件
		"编译生成pdf(下面已有设置为默认pdf)
		"并调用SumatraPDF软件打开
	elseif &filetype == 'tex'
		exec "silent make %"
		if (getqflist() == emptyerrorlist)
			if has ("win32")
				exec "!start sumatrapdf %<.pdf"
			endif
		endif
		exec "cw"

	endif
endfunc
"结束定义函数CompileRun


"-----------------------------------------------------------------
" taglist.vim  方便使用e-ctags自动生成tags并查看
" 回车或双击相应tag跳转到tag，o在新窗口打开，p预览，空格显示函数原型
" u更新tag列表，d删除tag，x切换全屏显示taglist窗口，+打开一个折叠，
" -关闭一个折叠，*打开所有折叠，=关闭所有折叠，[[或退格移动到前一个文件开头
"  ]]或tab移动到后一个文件开头，q关闭taglist窗口
"-----------------------------------------------------------------
"映射使用F8调出或关闭Taglist窗口
nnoremap <silent> <F8> :TlistToggle<CR> 
"Taglist窗口显示在屏幕右边，默认是显示在左边的
let Tlist_Use_Right_Window = 1
let Tlist_Show_Menu = 1
let Tlist_File_Fold_Auto_Close = 1
"highlight MyTagListFileName guifg=#a6e22e ctermfg=blue

if has("win32")     "设定windows系统中ctags程序的位置
	let Tlist_Ctags_Cmd = 'ctags'
elseif has("unix")   "设定linux系统中ctags程序的位置
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
elseif has("mac")    "指定Mac OS X下ctags的位置
	let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
endif

let winManagerWindowLayout = 'FileExplorer|TagList'

"-----------------------------------------------------------------
" mark.vim 给各种tags标记不同的颜色，便于观看调试的插件。
" \m mark or unmark the word under (or before) the cursor
" \r manually input a regular expression. 用于搜索.
" \n clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
" \* 当前MarkWord的下一个 \# 当前MarkWord的上一个
" \/ 所有MarkWords的下一个 \? 所有MarkWords的上一个
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :NRERDtree 打开NERD_tree :NERDtreeClose 关闭NERD_tree
" o打开关闭文件或者目录 t在标签页中打开
" T在后台标签页中打开 ! 执行此文件
" p到上层目录 P到根目录 K到第一个节点 J到最后一个节点
" u打开上层目录 m显示菜单（添加、删除、移动操作）
" r 递归刷新当前目录 R 递归刷新当前根目录
"-----------------------------------------------------------------
" F3 打开关闭NERDTree窗口
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
let NERDTreeWinSize=26  "NerdTree起始窗口大小
"let NERDTreeShowHidden=1  "设置默认显示隐藏文件


"-----------------------------------------------------------------------------
" bufexplorer.vim  方便查看vim的buffer并对buffer进行操作
" <L>be在当前窗口打开buffers，<L>bv以竖直分割的窗口打开，<L>bs以水平分割的窗口打开
" d删掉buf，D彻底删掉（擦除）buf，R切换显示相对/绝对路径，o当前窗口打开buf
" t新标签页打开buf，q退出bufexplorer窗口，
"-----------------------------------------------------------------------------
"映射F4为在新标签页以整个窗口显示所有buffers
map <F4> :tabnew<CR><leader>be


"-----------------------------------------------------------------
" plugin - NERD_commenter.vim 注释代码用的，
" [count]<L> cc cn cb cm cs添加注释
" [count]<L> cu 取消注释
" <L>cA 在行尾插入注释符,并且进入插入模式,方便写行注释。 
" 注：count参数可选，无则默认为选中行或当前行
"-----------------------------------------------------------------
let NERDSpaceDelims=1 " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1 " 多行注释时样子更好看


"--------------------------------------------------------------------------------
" vim latex-suite相关配置
" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
if has ("win32")
	set shellslash
endif

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" 设置默认生成pdf，对\ll及\lv都生效
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf,aux'
if has ("win32")
	let g:Tex_ViewRule_pdf = 'sumatrapdf'
endif
"--------------------------------------------------------------------------------
