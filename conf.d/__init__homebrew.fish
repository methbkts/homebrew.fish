if not type -q brew
    echo >&2 "brew command not found. Install from https://brew.sh"
    return 1
end
eval (brew shellenv)
