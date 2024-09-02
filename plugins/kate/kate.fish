# Kate
# Start kate always silent
alias kate='kate >/dev/null 2>&1'

function kt
  cd $argv[1]
  kate $argv[1]
end
