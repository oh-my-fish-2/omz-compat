# If the tm command is called without an argument, open TextMate in the current directory
# If tm is passed a directory, cd to it and open it in TextMate
# If tm is passed anything else (i.e., a list of files and/or options), pass them all along
#    This allows easy opening of multiple files.
function tm
    if test -z $argv[1]
        mate .
    else if test -d $argv[1]
        mate $argv[1]
        cd $argv[1]
    else
        mate $argv
    end
end
