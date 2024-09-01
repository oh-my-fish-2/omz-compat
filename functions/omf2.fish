function omf2 \
    --argument-names subcommand \
    --description "Oh-My-Fish2 command"

    # Temp HACK!
    if test "$argv[1..2]" = "prompt choose"
        __omf2_prompt_choose $argv[3..]
    else
        echo "OMF2: TODO - implement this!"
    end
end

function __omf2_prompt_choose \
    --description "Choose Oh-My-Fish2 prompt" \
    --argument-names prompt

    if not type -q starship
        echo >&2 "OMF2: Starship not found. Install starship from htts://starship.rs"
        return 1
    end

    starship init fish | source

    set --local gill
    set --local starship_config
    if test -n "$prompt"
        for gill in omz omf
            if test -r $__ohmyfish2/gills/$gill/prompts/$prompt.toml
                set starship_config $__ohmyfish2/gills/$gill/prompts/$prompt.toml
                break
            end
        end

        if test -n "$starship_config"
            set -gx STARSHIP_CONFIG $starship_config
        else
            echo >&2 "OMF2: prompt not found! List prompts with 'omf2 prompts --list'"
            return 1
        end
    end
end
