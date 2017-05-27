---
layout: post
title: "Configuring Bash: my .bashrc"
categories: Linux
author: gabriele_russorusso
comments: true
---

After showing my [ViM
configuration](http://hopandfork.org/2017/01/20/my-vimrc.html), in this post I
present another important *dotfile* from my own machine: `.bashrc`. It is parsed
every time a Bash
instance is launched. So, if you use Bash as your default terminal shell, that
file is loaded as soon as you launch a terminal instance.
As I will try to explain, there are many reasons for customizing `.bashrc`. I will
show you the most interesting parts of my configuration file, omitting those
specific to my particular setting. I suggest you to
look at them as examples for building (or extending) your own `.bashrc`.


Let's start with a preamble:
{% highlight bash %}
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
{% endhighlight %}
As the comment suggests, this first line is used to avoid parsing the whole file
if Bash is not run interactively (i.e., executing scripts).

The next section configures the *prompt* string, displaying more information and
making it colorful. Customizing the prompt seems just a matter of aesthetics, but it is not.
It is printed every time you execute a command in the terminal, thus making it
show what you really care is not pointless. So, the first thing to do is defining some colors:

{% highlight bash %}
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
NORMAL=$(tput sgr0)
# Example:
# echo "${RED}this is red ${NORMAL}this is normal"
# BUT in prompt, they must be put between \[ and \] to avoid line wrapping issues
{% endhighlight %}

Having defined a few colors, we can now customize the prompt string:
{% highlight bash %}
# PROMPT
source ~/.git-prompt.sh

function mygitprompt
{
	local gitprompt=$(__git_ps1)
	if [ ${#gitprompt} -gt 0 ]; then
		echo "$gitprompt "
	else
		echo " "
	fi
}

function countJobs
{
	local count=`jobs -p | wc -l`
	if [ $count -gt 0 ]; then
		echo "[$count] ";
	fi
}

if [[ "$SSH_CLIENT" != "" ]]; then
	SSH_PROMPT='SSH|'
fi

PS1='\[${RED}\]${SSH_PROMPT}\[${GREEN}\]\W\[${MAGENTA}\]$(mygitprompt)\[${NORMAL}\]$(countJobs)\$ '
{% endhighlight %}

As you can see, I load an external script, named `git-prompt.sh`, which allows to
easily include information about *git* repositories in the prompt. The script is
available
[here](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh)
under the terms of GPLv2. When the working directory is in a repository, it
displays the current branch and signals other particular conditions (e.g., if we
		are in the middle of a *merge* operation). I also like to have a
count of the active jobs displayed, when one or more of background jobs exist.
This is accomplished by `countJobs` function. Finally, in my prompt I always
have the name of the current working directory. I do not have username or
hostname printed, since I usually remember who I am and where I am working ;-). However,
if I access the machine via SSH, the prompt signals this condition with
a `SSH|` prefix.

![prompt](https://raw.githubusercontent.com/hopandfork/hopandfork.github.io/master/public/images/post/my-bashrc.png)

One of the main reasons you have for customizing your `.bashrc` is the
possibility to define aliases and functions. In this way, you can create shortcuts for
quickly executing possibly complex operations in the shell, or transparently
"change" the default behavior of some commands. For example:

{% highlight bash %}
# shortcuts for accessing directories
alias uni="cd /home/user/Documents/university/"
# ...

# shortcuts for commands
alias ll='ls -lh --color=auto --group-directories-first'
alias ls='_ls'
function _ls
{
	if [[ $# -gt 0 ]]; then
		'ls' $@;
	else
		'ls' -F -1 --color=auto --group-directories-first;
	fi
}

alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'

alias df='df -h'
alias free='free -h'
alias vi='vim'
alias lessend='less +G'
alias remake='make clean && make'
alias vmstat='vmstat -S M -w'
alias bc='bc -l'

# for git
alias gis='git status --short'
alias gil='git log --graph --oneline --decorate=full'

# for managing wifi through NetworkManager
alias wifi_on='sudo nmcli radio wifi on'
alias wifi_off='sudo nmcli radio wifi off'

# opens the given file with the associated graphical application
function run
{
	xdg-open "$@" 2> /dev/null 
}

{% endhighlight %}

The aliases and functions shown above are just examples of what you can achieve.
For example, I find it really useful to have `free` and `df` always showing results in a
human-readable format. If at any time you need to use the non-aliased version of
the command, it is enough to type it between quotes: `'free'`. As you
can see, aliases are the
simplest tool to define shortcuts, but functions offer more flexibility.

`.bashrc` is one of the possible places for customizing the `PATH` environment
variable. I usually include in `PATH` a directory where I place my own scripts:
{% highlight bash %}
export PATH=$PATH:$HOME/Scripts
{% endhighlight %}

I also added two lines for controlling Bash history. In particular, I do not
want duplicates, and prefer to have the latest entries *appended* to the file.
The latter option is useful to avoid history overwriting when using multiple
shell instances simultaneously. 

{% highlight bash %}
export HISTCONTROL=ignoredups
shopt -s histappend
{% endhighlight %}

I also find it useful to enable a keyboard shortcut in the shell. `Ctrl+W` is
the default shortcut for deleting everything from the current cursor position to
the beginning of the previous word. I set `Ctrl+P` for deleting till the end of
the *next* word.

{% highlight bash %}
bind '"\C-p": shell-kill-word'
{% endhighlight %}

As always, you are ready (and free) to take what you like from my `.bashrc`.
If you have other tricks to suggest, post a comment!
