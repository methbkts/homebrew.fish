# Find the brew command
set brewcmds (
    path filter \
        $HOME/.homebrew/bin/brew \
        $HOME/.linuxbrew/bin/brew \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew
    )
if test (count $brewcmds) -eq 0
    echo >&2 "brew command not found. Install from https://brew.sh"
    return 1
end
$brewcmds[1] shellenv | source

# If the brew path is owned by another user, wrap it so brew commands
# are executed as the brew owner.
set -gx HOMEBREW_OWNER (stat -f "%Su" $HOMEBREW_PREFIX)
if test $HOMEBREW_OWNER != (whoami)
    function brew --description 'Wrap brew with sudo for multi-user systems'
        sudo -Hu $HOMEBREW_OWNER brew $argv
    end
end
