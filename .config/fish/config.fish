function fish_greeting
end

function fish_prompt
  echo "local > "
end

function fish_right_prompt
  pwd | awk -F/ '{ print $(NF-1)"/"$NF }'
end

function ped
  ~/src/panther/panther edit $argv
end

function pat
  ~/src/panther/panther cat $argv
end

function cg
  pat ~/Sync/coon/$argv | /usr/bin/tr -d '\n' | /usr/bin/pbcopy
end

function cm
  ped ~/Sync/coon/$argv
end

function gpass
  /usr/local/bin/pwgen -nys $argv 1 | /usr/bin/tr -d '\n' | /usr/bin/pbcopy
end

function nmutt-prime
  /usr/local/bin/neomutt -F ~/.config/neomutt/prime.muttrc
end

function nmutt-utexas
  /usr/local/bin/neomutt -F ~/.config/neomutt/utexas.muttrc
end

set options (ls ~/Sync/coon/)
complete --command cg --no-files --exclusive --arguments "$options"
complete --command cm --no-files --exclusive --arguments "$options"

set -g -x EDITOR nvim
set -g -x PATH $PATH /Users/klaus/Library/Python/3.7/bin/
