function z -d "jump around"
    set -lx z_script_dir (dirname (status -f))/.external
    set -lx z_script_path $z_script_dir/z.sh
    if not test -f $z_script_path
        git clone --quiet https://github.com/rupa/z.git $z_script_dir
    end

    # Start a Bash process, source z, run the _z function, and capture the working directory and exit status.
    bash -c '
        source "$z_script_path"
        _z "$@" 2>&1
        z_status=$?
        echo "$PWD|$z_status" >&2
        exit $z_status
    ' bash $argv 2>| read -l z_result
    set -l z_status $status
    set -l arr_z_result (string split "|" $z_result)

    set -l z_pwd $arr_z_result[1]
    if test $z_status -eq 0
        set z_status $arr_z_result[2]
    end

    # If z changed directories, reflect that in the current process.
    if test $z_pwd != $PWD
        echo "z jumping to $z_pwd"
        builtin cd $z_pwd
    end

    return $z_status
end

function z.pwd --on-variable PWD
    status --is-command-substitution; and return
    z --add $PWD
end

function z.complete
    z -l $argv | awk '{print $2}'
end

complete -c z -s c -d "Restrict matches to subdirectories of the current directory"
complete -c z -s h -d "Show a brief help message"
complete -c z -s l -d "List only"
complete -c z -s r -d "Match by rank only"
complete -c z -s t -d "Match by recent access only"
complete -c z -s x -d "Remove the current directory from the datafile"

complete -c z --no-files -a '(z.complete)'
