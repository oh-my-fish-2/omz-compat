# Support Fisher's plugin events
function _omz_compat_install --on-event omz_compat_install
    type --query omf2 && omf2 install oh-my-fish2/omz-compat
end

function _omz_compat_update --on-event omz_compat_update
    type --query omf2 && omf2 update oh-my-fish2/omz-compat
end

function _omz_compat_uninstall --on-event omz_compat_uninstall
    type --query omf2 && omf2 uninstall oh-my-fish2/omz-compat
end
