function fish_greeting
end

function fish_prompt
  echo "local > "
end

function fish_right_prompt
  pwd | awk -F/ '{ print $(NF-1)"/"$NF }'
end

set -g -x EDITOR nvim
set -g -x PATH $HOME/apps/go/bin $PATH $HOME/apps/bin

alias audio-hdmi="pacmd set-card-profile 0 output:hdmi-stereo+input:analog-stereo"
alias audio-laptop="pacmd set-card-profile 0 output:analog-stereo+input:analog-stereo"

function panther
   ~/src/panther/_build/default/bin/panther.exe $argv
end

set PW_STORE $HOME/src/panther-store-keys

function ped
  panther edit $argv
end

function reduce-arg-to-key
  # Replace whitespaces and '\'s with '-'.
  set key (echo "$argv" | sed 's/\s/-/g')
  echo "$key" | sed 's/\\\\/-/g'
end

function sync-pass
  pushd "$PW_STORE"
  /usr/bin/git pull origin master 1> /dev/null

  popd
end

function list-pass
  set key (reduce-arg-to-key $argv)
  /usr/bin/ls "$PW_STORE"
end

function mod-pass
  pushd "$PW_STORE"
  /usr/bin/git pull origin master 1> /dev/null

  set -l keys
  set -l names

  for arg in $argv
    if test "$arg" = ""
      # Couldn't find the key, list all existing ones.
      list-pass

    else
      set key (reduce-arg-to-key $arg)

      # Check if a file with the key exists.
      if test -e "$PW_STORE"/$key
        ped $key

        # Add the key to the list of keys so that we can commit changes to repo.
        set -a keys $key
        set -a names $arg

      else
        # Since the key doesn't exist, ask if we want to create one.
        while true

          read -P "Password for '$arg' does not exist.  Create one manually? [Y/n] " create
          set create (string lower $create)

          if test "$create" = ""; or test "$create" = "y"
            ped "$PW_STORE"/$key

            # Add the key to the list of keys so that we can commit changes to repo.
            set -a keys $key
            set -a names $arg

            break

          else if test "$create" = "n"
            break
          end
        end
      end
    end
  end

  # Commit changes if any to the remote repository.
  if test "$keys" != ""
    /usr/bin/git add $keys

    set message (printf "Updates key(s) for %s." (string join ', ' $names))
    /usr/bin/git commit -m "$message"

    /usr/bin/git push origin master 1> /dev/null
  end

  # Switch back to the original directory.
  popd
end

function dump-pass
  pushd "$PW_STORE"

  if test "$argv" = ""
    list-pass
  else
    set key (reduce-arg-to-key $argv)

    # Check if a file with the key already exists.
    if test -e "$PW_STORE"/$key

      # The first line contains the key, the rest is auxiliary info.
      panther dec "$PW_STORE"/$key - | head -n1
    else
      echo "Could not find key for '$argv'.  Try `list-pass`."
    end
  end

  popd
end

function get-pass
  if test "$argv" = ""
    list-pass
  else
    dump-pass $argv | /usr/bin/tr -d '\n\r' | /usr/bin/xclip -selection c
  end
end

function new-pass
  pushd "$PW_STORE"

  # Make sure we're up to date with the remote repository.
  /usr/bin/git pull origin master

  set -l keys
  set -l names

  # Create a key for every input key.
  for arg in $argv
    set key (reduce-arg-to-key $arg)

    # Check if a file with the key already exists, and if so, skip.
    if test -e "$key"
      echo "Password for '$key' already exists.  Did you mean `mod-pass '$key'?"
    else
      # Generate a key using preset rules.
      /usr/bin/apg -a1 -n1 -m50 -MSNCL -E`~\(\)-_=+\[\]\{\}\\\|\;:\'\",\<.\>/\? | panther enc - $key
      echo "Created new key, fetch using `get-pass "$key"`."

      # Add the key to the list of keys so that we can commit changes to repo.
      set -a keys $key
      set -a names $arg
    end
  end

  # Commit changes if any to the remote repository.
  if test "$keys" != ""
    /usr/bin/git add $keys

    set message (printf "Adds key(s) for %s." (string join ', ' $names))
    /usr/bin/git commit -m "$message"

    /usr/bin/git push origin master
  end

  # Switch back to the original directory.
  popd
end

# opam configuration
source /home/klaus/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
