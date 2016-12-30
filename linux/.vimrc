"	***************************************************
"		^> File Name: .vimrc
"		^> Author: AoEiuV020
"		^> Mail: 490674483@qq.com
"		^> Created Time: 2015/01/04 - 23:43:55
"	***************************************************

"上面的信息不是一开始就加的，是在我用了很久后，开始加注释时加上的，

"首先是判断环境，copy来的，
"g:iswindows
"g:islinux
"g:isgui
"意思都很明确了，
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
	let g:iswindows = 1
else
	let g:islinux = 1
endif
if has("gui_running")
	let g:isgui = 1
else
	let g:isgui = 0
endif

"去掉vi兼容，兼容的话就用不了vim中比较高级的东西，
set nocompatible
"设置语言，英文，避免各种问题，
if (g:iswindows)
	let $LANG="en"
	set langmenu=en
else
	lang en_US.utf8
endif
"检查文件类型，有这个才能针对不同文件做预处理，
filetype indent on 
"新文件自动设置开头的作者信息，
autocmd BufNewFile * exe "call SetTitle()"
func SetTitle()
	if &filetype == "java"
		call InfoJavaDoc()
	endif
	for type in ["c","cpp"]
		if &filetype == type
			let com="multi"
			let start="/* "
			let end=" */"
		endif
	endfor
	for type in ["html"]
		if &filetype == type
			let com="multi"
			let start="<!--"
			let end="-->"
		endif
	endfor
	for type in ["sh","python","dosini","make"]
		if &filetype == type
			let com="single"
			let start="\\#"
			"#需要用\转义，\本身也要转义，
		endif
	endfor
	for type in ["lua"]
		if &filetype == type
			let com="multi"
			let start="--[["
			let end="--]]"
		endif
	endfor
	for type in ["sql","mysql"]
		if &filetype == type
			let com="single"
			let start="-- "
		endif
	endfor
	for type in ["dosbatch"]
		if &filetype == type
			let com="single"
			let start="rem"
		endif
	endfor
	for type in ["vim"]
		if &filetype == type
			let com="single"
			let start="\""
		endif
	endfor
	"这里设置作者信息，并根据上面的分类，加上注释，
	"分成单行注释和多行注释，
	if exists("com")
		call Info()
		let curline=(line("."))
		if com == "single"
			call Comment(1,start."\<TAB>")
		elseif com == "multi"
			exe "1s#^#".start
			normal G
			exe "normal ".curline."G"
			exe "".(line(".")-1)."s#$#".end
			normal G
		endif
	endif
	"下面是不同类型文件在加信息后要做的，比如把作者信息折叠起来，
	for type in ["c","cpp"]
		if &filetype == type
			normal zM
		endif
	endfor
	for type in ["dosbatch"]
		if &filetype == type
			call append(0,"@echo off")
		endif
	endfor
	for type in ["sh"]
		if &filetype == type
			call append(0,"#!/bin/sh")
		endif
	endfor
	for type in ["lua"]
		if &filetype == type
			call append(0,"#!/bin/lua")
		endif
	endfor
	for type in ["python"]
		if &filetype == type
			call append(0,"# -*- coding: utf-8 -*-")
			call append(0,"#!/bin/python")
			set fenc=utf-8
		endif
	endfor
	normal G
	if &filetype == "java"
		call append(line(".")-1, "public class ".expand("%:t:r")."{")
		call append(line("."), "")
		call append(line("."), "}")
	endif
endfunc
func Info()
	call append(line(".")-1, "***************************************************")
	call append(line(".")-1, "	^> File Name: ".expand("%:t"))
	call append(line(".")-1, "	^> Author: AoEiuV020")
	call append(line(".")-1, "	^> Mail: aoeiuv020@qq.com")
	call append(line(".")-1, "	^> Created Time: ".strftime("%Y/%m/%d - %H:%M:%S"))
	call append(line(".")-1, "***************************************************")
endfunc
func InfoJavaDoc()
	call Package()
	call append(line(".")-1, "/**")
	call append(line(".")-1, " * @author AoEiuV020")
	call append(line(".")-1, " * @version 1.0, ".strftime("%Y/%m/%d"))
	call append(line(".")-1, " */")
endfunc
func Package()
	let oldline=line(".")
	let package=expand("%:p:h")
	"exec "normal i"."package ".package.";"
	call append(0, "package ".package.";")
	if getline(1) =~# "src/"
		exec "1s# .*src/# #g"
	endif
	if getline(1) =~# "java/"
		exec "1s# .*java/# #g"
	endif
	if getline(1) =~# "/"
		exec "1s#/#.#g"
	endif
	normal j
endfunc
func Comment(start,com)
	exe "".a:start.",".(line(".")-1)."s#^#".a:com
	normal j
endfunc
func EndCom(start,endcom)
	exe "".a:start.",".(line(".")-1)."s#$#".a:endcom
	normal j
endfunc
func Indent()
	let curline=line(".")
	exe "%!indent"
	exe "%s/const \\?const/const"
	exe "normal ".curline."G"
endfunc
func C()
	call append(line(".")-1, "#include <stdio.h>" )
	call append(line(".")-1, "int main(int argc, char **argv)")
	call append(line(".")-1, "{")
	call append(line("."), "}")
	call append(line("."), "\<TAB>return 0;")
	execute "normal i\<TAB>\<ESC>"
endfunc
func Cpp()
	call append(line(".")-1, "#include <iostream>" )
	call append(line(".")-1, "using namespace std;" )
	call append(line(".")-1, "int main(int argc, char **argv)")
	call append(line(".")-1, "{")
	call append(line("."), "}")
	call append(line("."), "\<TAB>return 0;")
	execute "normal i\<TAB>\<ESC>"
	"ToDo 添加Tab可以不要，
endfunc
func Java()
	call append(line(".")-1, "\tpublic static void main(String[] args){")
	call append(line("."), "\t}")
endfunc
func Html()
	call append(line(".")-1, "<!doctype html>" )
	call append(line(".")-1, "<html>" )
	call append(line(".")-1, "\<TAB><head>" )
	call append(line(".")-1, "\<TAB>\<TAB><title>".expand("%:t")."</title>" )
	call append(line(".")-1, "\<TAB>\<TAB><meta charset=\"utf-8\" name=\"viewport\" content=\"user-scalable=no, width=device-width\" />" )

	call append(line(".")-1, "\<TAB></head>" )
	call append(line(".")-1, "\<TAB><body>" )
	call append(line(".")-1, "\<TAB>\<TAB><p>" )
	call append(line("."), "</html>" )
	call append(line("."), "\<TAB></body>" )
	call append(line("."), "\<TAB>\<TAB></p>" )
	execute "normal i\<TAB>\<TAB>\<ESC>"
endfunc
"不要生成备份文件，和交换文件，事实证明通常是多余的，
set nobackup
set noswapfile
"左边的行号，
set number
"底下的状态栏，
set statusline=%F%m%r%h%w%=[%{&fenc},%{&ff},%Y][%l,%v][\%03.3b,\%02.2B]\[%p%%,%O]\ %{strftime(\"%H:%M:%S\")}
set laststatus=2
"退格键，加了这个才能象其他编辑器一样使用，vi的退格键实在习惯不了，
set backspace=2
"让光标移动可以跨行，
set whichwrap=b,s,h,l,<,>,~,[,]
"使用鼠标，话说win下
"set mouse=a
set mouse=
"选择模式的一些设置，
set selection=inclusive
set selectmode=mouse,key
"打开语法高亮，
syntax on
"如果文件有改变，自动读取，不喜欢，
"set autoread
"设置tab，长度为4，
set tabstop=4
"代码中的tab键长度，
set softtabstop=4
"好像是自动缩进的长度，
set shiftwidth=4
"不用空格代替tab，据说用是因为有的公司要求不用tab，
set noexpandtab
"高亮搜索，
set hlsearch
"逐步搜索，一个一个字母输入同时搜索，
set incsearch
"滚动搜索，
set wrapscan
"符号自动补全大部分都是copy来的，
inoremap ( ()<Esc>i
"inoremap < <><Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf
"花括号的补全，copy来的，很高级，
function CloseBracket()
	if getline('.')[col('.') - 1] == '}'
		return "\<Right>"
	elseif match(getline(line('.') + 1), '}') < 0
		return "}"
	else
		return "\<Esc>j0f}a"
	endif
endf
"好复杂，用不懂，但是很顺手，
function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf
"自己写的，用来配合上面那个的花括号，
inoremap <CR> <c-r>=AoEiuV_CR()<CR>
function AoEiuV_CR()
	if getline('.')[col('.') - 1] == '}'
		return "\<CR>\<ESC>O"
	else
		return "\<CR>"
	endif
endf
"encoding,utf-8 in unix,cp936 equal gbk in win...
"encoding是缓存的编码，不用改也不能乱改，
"fileencoding是新文件的编码，
"fileencodings是打开文件时判断编码的顺序，utf-8不能在cp936的后面，vim会把utf-8都识别为cp936，
"termencoding是显示的编码，win下可以用utf-8处理，然后gbk显示，
if (g:iswindows)
	"set encoding=cp936
	"set termencoding=cp936
	set fileencoding=cp936
else
	"set encoding=utf-8
	"set termencoding=utf-8
	set fileencoding=utf-8
endif
"加了下面这段才if能读unicode，应该是只有termencoding和fileencodings都有用，
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	"set encoding=utf-8
	"setglobal fileencoding=utf-8
	"setglobal bomb
	set fileencodings=ucs-bom,utf-8,cp936,ucs-bom,shift-jis,gb18030,gb2312,latin1
endif
"set fileencodings=utf-8,cp936,ucs-bom,shift-jis,gb18030,gb2312
"设置换行符的类型，
set fileformats+=mac
"打开vimrc，
function V()
	if (g:iswindows)
		let vimrc="$VIM/_vimrc"
	else
		let vimrc="~/.vimrc"
	endif
	exe "new ".vimrc
	winc _
endfunc
"关于代码折叠的，
"zo,zc,zr,zm,za...
set foldmethod=syntax
set foldlevel=100
"set foldenable
"窗口最大最小化，
let g:lines=&lines
let g:columns=&columns
function Win(size)
	if a:size == "max"
		if (g:iswindows)&&(g:isgui)
			simalt ~x
		else
			winpos -3 -3
			"win下试出来的，-3刚好上下左右都在边界，都能让鼠标变成箭头，
			if (g:iswindows)||(g:isgui)
				set lines=999 columns=999
				set lines-=1 columns-=1
			endif
		endif
	elseif a:size == "min"
		if (g:iswindows)&&(g:isgui)
			simalt ~r
		else
			let &lines=g:lines
			let &columns=g:columns
		endif
	elseif a:size == "F12"
		if &lines > g:lines
			call Win("min")
		else
			call Win("max")
		endif
	else
		echo "error..."
	endif
endfunc
map <F12> :call Win("F12")<CR>
imap <F12> <ESC><F12>
"指定配色方案为256色
set t_Co=256
"高亮当前行列，列不好看，不要，
set cursorline
if (g:iswindows&&!g:isgui)
	highlight CursorLine cterm=none ctermbg=2048
endif
"set cursorcolumn
"配色方案，其实就是主题，
"default默认的就挺好，只是linux桌面版的终端vim的注释有点看不清，所以换一个，
if (!g:iswindows&&!g:isgui)
	colorscheme slate
endif
"命令行自动补全时显示选项，
set showcmd
set wildmenu
