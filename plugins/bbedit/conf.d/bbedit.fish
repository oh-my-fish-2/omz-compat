alias bbpb='pbpaste | bbedit --clean --view-top'

alias bbd=bbdiff

#
# If the bb command is called without an argument, launch BBEdit
# If bb is passed a directory, cd to it and open it in BBEdit
# If bb is passed a file, open it in BBEdit
#
function bb
    if test -z $argv[1]
        bbedit --launch
    else
        bbedit $argv[1]
        if test -d $argv[1]
            cd $argv[1]
        end
    end
end
