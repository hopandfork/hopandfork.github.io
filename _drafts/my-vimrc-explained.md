---
layout: post
title: "Configuring ViM: my .vimrc explained"
categories: Configuration Programming
author: gabriele_russorusso
comments: true
---

[ViM](http://www.vim.org) is one of the most popular text editors on Linux. If
you are a programmer and you haven't ever used it, you should probably give 
it a try (after reading a primer like [this](https://danielmiessler.com/study/vim/#gs.944UoJI)).
ViM is extremely powerful and has got a lot of awesome features. However, some
of them are not enabled by default, so a good configuration can make the
difference.

I am going to share my `.vimrc` file with you. It is the result of many incremental
additions (inspired by tricks I found on the web) and it is definitely not perfect yet.
In this post, I will present 
its various sections trying to explain what they do. Some lines will
probably look weird...and indeed they are! ;-) 

Let's begin!

{% highlight vim %}
syntax on
set nocompatible
{% endhighlight %}

The first line enables syntax highlighting. The second one is usually
unnecessary and tells ViM not to
run in *compatible mode* (i.e. compatible with old **vi**). 

{% highlight vim %}
set number	
set relativenumber
{% endhighlight %}

The first line simply makes ViM display line numbers, like other editors do. The
second one tells it to use **relative** numbers: you will see the absolute line
number on the current line and the distance from it on the other ones. *Why?!*
It simplifies the usage of commands like `6dd`, `5j` and so on.

{% highlight vim %}
set showmatch
set hlsearch
set smartcase
set incsearch
{% endhighlight %}

This block is about searching. It tells ViM to be *smart* when choosing between
case sensitive and insensitive search and to highlight matches (if any).
	 
{% highlight vim %}
set autoindent
set cindent
set shiftwidth=8
set smartindent
set smarttab
set softtabstop=8
set tabstop=8
set noexpandtab
filetype plugin indent on
set backspace=indent,eol,start
{% endhighlight %}

This block is about indentation. I like to use hard tabs to indent and display
them 8-spaces wide. You should adjust these settings according to your
preferences. Here I also enable `filetype` plugin to have custom indentation
tules for specific file types (e.g. `.py`).

{% highlight vim %}
noremap <Up> <NOP>
noremap <Down> <NOP>
nmap <silent> <Left> <<
nmap <silent> <Right> >>
vmap <silent> <Left> <
vmap <silent> <Right> >
imap <silent> <Left> <C-D>
imap <silent> <Right> <C-T>
{% endhighlight %}

If you have ever read a tutorial about ViM, I am sure the author tried to 
convince you that the best way to move around the text is using `h`, `j`,
`k` and `l` (and not arrow keys). I agree. But I know how difficult it is to
get used to that. The only way that worked for me was disabling the arrow keys!
Actually, it wouldn't be nice to waste those keys. So arrow keys are simply
re-mapped to perform indentation (in normal, insert and visual mode).

{% highlight vim %}
set noeb vb t_vb=
{% endhighlight %}

This is a little bit weird. It disables both bell and visual bell for ViM,
which may be annoying (e.g. when pressing `Esc` in Normal mode, with no effect).

{% highlight vim %}
set linebreak
set showbreak=+++
set textwidth=100
set wrap
set colorcolumn=80
set fo-=t 
{% endhighlight %}

This block tells ViM to wrap text after 100 columns (everyone has a friend who
silently ignores the 80-columns rule!). The wrapped text is displayed after
the `+++` string. I ask ViM to highlight 80th column to help me stay in the
bound. The last line disables *physical* line breaking (everyone
wants to break the 80-columns rule sometimes...).

{% highlight vim %}
set autochdir
set undolevels=1000
set nobackup
set swapfile
set dir=/tmp
{% endhighlight %}

The first line tells ViM to automatically change its current directory after
opening a new file; the second one sets the available *undo leveles* to 1000.
Last lines disable backup files (`~`) and enable swap files (`.swp`) to be
stored in `/tmp`.

{% highlight vim %}
set foldmethod=syntax
set nofoldenable    
:nnoremap <space> zA
{% endhighlight %}

This last block configures folding in ViM. It should be based on syntax (e.g.
fold a function definition, a block of code, ...), but it is disabled at
startup. I also remap `zA` to spacebar to toggle folding.

Okay...you are ready (and free) to take what you like from my `.vimrc`, which is
available [here](https://gist.github.com/childerico/1da555429dd8f16ca82adeaeb06a12ac).
If you have other tricks to suggest, post a comment!
