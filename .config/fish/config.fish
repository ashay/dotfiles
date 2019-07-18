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
  pat ~/Dropbox/coon/$argv | tr -d '\n' | pbcopy
end

function cm
  ped ~/Dropbox/coon/$argv
end

set options (ls ~/Dropbox/coon/)
complete --command cg --no-files --exclusive --arguments "$options"
complete --command cm --no-files --exclusive --arguments "$options"

set -g -x EDITOR nvim
