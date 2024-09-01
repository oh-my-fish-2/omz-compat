set -q __ohmyfish2 || set -g __ohmyfish2 $__fish_config_dir/.ohmyfish2

# Fisher events
function _ohmyfish2_install --on-event ohmyfish2_install
    if test -d $__ohmyfish2
        rm -rf -- $__ohmyfish2
    end
    git clone --quiet https://github.com/ohmy2fish/ohmyfish2 $__ohmyfish2
end

function _ohmyfish2_update --on-event ohmyfish2_update
    git -C $__ohmyfish2 pull --quiet
end

function _ohmyfish2_uninstall --on-event ohmyfish2_uninstall
    rm -rf -- $__ohmyfish2
end
