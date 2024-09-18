# https://github.com/dbbolton
#
# Below are some useful Perl-related aliases/functions that I use with zsh.


# Aliases ###################################################################

# perlbrew ########
alias pbi='perlbrew install'
alias pbl='perlbrew list'
alias pbo='perlbrew off'
alias pbs='perlbrew switch'
alias pbu='perlbrew use'

# Perl ############

# perldoc`
alias pd='perldoc'

# use perl like awk/sed
alias ple='perl -wlne'

# show the latest stable release of Perl
alias latest-perl='curl -s https://www.perl.org/get.html | perl -wlne '\''if (/perl\-([\d\.]+)\.tar\.gz/) { print $1; exit;}'\'



# Functions #################################################################

# newpl - creates a basic Perl script file and opens it with $EDITOR
#newpl () {
function newpl
    # set $EDITOR to 'vim' if it is undefined
    test -z "$EDITOR" && set EDITOR vim

    # if the file exists, just open it
    test -e "$argv[1]" && echo "$argv[1] exists; not modifying." && $EDITOR $argv[1]

    # if it doesn't, make it, and open it
    not test -e $argv[1] && echo '#!/usr/bin/perl'\n'use strict;'\n'use warnings;'\n \
        > $argv[1] && $EDITOR $argv[1]
end


# pgs - Perl Global Substitution
# find pattern    = 1st arg
# replace pattern = 2nd arg
# filename        = 3rd arg
#pgs() { # [find] [replace] [filename]
function pgs
    perl -i.orig -pe 's/'$argv[1]'/'$argv[2]'/g' $argv[3]
end


# Perl grep, because 'grep -P' is terrible. Lets you work with pipes or files.
#prep() { # [pattern] [filename unless STDOUT]
function prep
    perl -nle 'print if /'$argv[1]'/;' $argv[2]
end
