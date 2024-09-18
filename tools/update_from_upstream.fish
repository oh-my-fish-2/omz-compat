set --global projdir (path resolve (status dirname)/..)

function update_from_upstream
    set --local omz $projdir/.external/omz
    if not test -d $omz
        git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh $omz
    else
        git -C $omz pull --quiet
    end

    set --local core $projdir/.external/core
    if not test -d $core
        git clone --quiet --depth 1 https://github.com/omf2/core-plugin-pack $core
    else
        git -C $core pull --quiet
    end

    set --local empty_plugins (
        path basename (path dirname (find $omz -name "*.plugin.zsh" -size 0)) | sort
    )

    set --local core_plugins (
        path basename $core/plugins/* | sort
    )

    set --local omz_compat_plugins (
        path basename $projdir/plugins/* | sort
    )

    set --local alias_only_plugins (
        path basename (path dirname (
            find $omz/plugins -name "*.plugin.zsh" -type f \
            -exec sh -c 'grep -v -E "^\s*($|#|alias\s)" "{}" | grep -q . || echo "{}"' \; |
            sort
        ))
    )

    # omz_compat should not have overlapping plugins
    for plugin in $omz_compat_plugins
        if contains $plugin $core_plugins
            echo "Duplicate plugin found... $plugin"
        end
    end

    # symmetric diff
    for item in $empty_plugins
        set --local i (contains -i $item $alias_only_plugins) || set i 0
        if test "$i" -gt 0
            set --erase alias_only_plugins[$i]
        end
    end

    set --local compat_path
    for plugin in $alias_only_plugins
        set plugin_path $omz/plugins/$plugin/$plugin.plugin.zsh
        set compat_path $projdir/plugins/$plugin/conf.d/$plugin.fish
        mkdir -p (path dirname $compat_path)
        cp -f $plugin_path $compat_path
    end
end
update_from_upstream $argv
