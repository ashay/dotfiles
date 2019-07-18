function fish_greeting
end

function fish_prompt
  echo "local > "
end

function fish_right_prompt
  pwd | awk -F/ '{ print $(NF-1)"/"$NF }'
end

set -g -x EDITOR nvim
