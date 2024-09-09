if not type -q omf2 && type -q fisher
    fisher install oh-my-fish-2/omf2
end

# Support Fisher's plugin events
function _omz_compat_install --on-event omz_compat_install
    omf2 handle install oh-my-fish-2/omz-compat
end

function _omz_compat_update --on-event omz_compat_update
    omf2 handle update oh-my-fish-2/omz-compat
end

function _omz_compat_uninstall --on-event omz_compat_uninstall
    omf2 handle uninstall oh-my-fish-2/omz-compat
end
