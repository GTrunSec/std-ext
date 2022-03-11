export VAULT_DEV_ROOT_TOKEN_ID=root
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN_ID

function log {
    local index="$1"
    local name="$2"
    local color=$((31 + (index % 7)))
    while IFS= read -r; do
        >&2 printf "\033[0;''${color}m%s |\033[0m " "$name"
        printf "%s\n" "$REPLY"
    done
}

function cleanup {
    >&2 echo 'Stopping processes… (please provide password again if necessary)'
    sudo kill "$(jobs -p)" 2> /dev/null || :
    sleep 1
    if [[ -n "$(jobs -rp)" ]]; then
        >&2 echo 'There are survivors:'
        jobs -l
        >&2 echo 'Retrying…'
        cleanup
    fi
}

trap cleanup EXIT


vault server -dev |& log 0 vault &

sudo --preserve-env=PATH,VAULT_TOKEN \
nomad agent -dev \
    -plugin-dir "$nomadPlugins/bin" \
    -config "$nomadConfig"

nix-cache-proxy \
    --substituters 'https://cache.nixos.org' \
    --secret-key-files "$secretFile" \
    --trusted-public-keys 'cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' \
    --listen :7745 \
    --dir nix-cache-proxy \
    |& log 3 nix-cache-proxy &

wait
