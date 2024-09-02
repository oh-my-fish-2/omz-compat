# Autocompletion for the GitHub CLI (gh).
type -q gh || return

gh completion --shell fish | source
