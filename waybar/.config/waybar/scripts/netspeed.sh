#!/usr/bin/env bash
# Network up/down speed indicator for waybar.
# Outputs JSON: { text, tooltip, class }.
# Configure waybar to poll on an interval; the script remembers the
# previous reading in a /tmp state file to compute deltas.

STATE=/tmp/waybar-netspeed.state

rx_total=0
tx_total=0
ifaces=()

while IFS= read -r line; do
    [[ "$line" != *:* ]] && continue
    iface="${line%%:*}"
    iface="${iface// /}"
    case "$iface" in
        lo|veth*|docker*|br-*|virbr*|tun*|tap*|tailscale*) continue ;;
    esac
    stats="${line#*:}"
    # /proc/net/dev columns: rx_bytes ... tx_bytes is field 9 of the post-colon part
    read -r r _ _ _ _ _ _ _ t _ <<<"$stats"
    rx_total=$((rx_total + r))
    tx_total=$((tx_total + t))
    ifaces+=("$iface")
done </proc/net/dev

now_ns=$(date +%s%N)

if [[ -f $STATE ]]; then
    read -r old_rx old_tx old_ns <"$STATE"
    dt_ms=$(( (now_ns - old_ns) / 1000000 ))
    (( dt_ms < 1 )) && dt_ms=1
    drx=$(( (rx_total - old_rx) * 1000 / dt_ms ))
    dtx=$(( (tx_total - old_tx) * 1000 / dt_ms ))
    (( drx < 0 )) && drx=0
    (( dtx < 0 )) && dtx=0
else
    drx=0
    dtx=0
fi

printf '%s %s %s\n' "$rx_total" "$tx_total" "$now_ns" >"$STATE"

fmt() {
    local b=$1
    if   (( b < 1024 ));            then printf '%dB/s'   "$b"
    elif (( b < 1024*1024 ));       then printf '%dKB/s'  "$((b/1024))"
    elif (( b < 1024*1024*1024 ));  then
        local mb_x10=$(( b * 10 / (1024*1024) ))
        printf '%d.%dMB/s' $((mb_x10/10)) $((mb_x10%10))
    else
        local gb_x10=$(( b * 10 / (1024*1024*1024) ))
        printf '%d.%dGB/s' $((gb_x10/10)) $((gb_x10%10))
    fi
}

down=$(fmt "$drx")
up=$(fmt "$dtx")

# Pango markup for the icons (Nerd Font glyphs)
text=" $down   $up"
tooltip="Network rates\nDown: $down\nUp:   $up\nInterfaces: ${ifaces[*]:-none}"

# Escape newlines for JSON
tooltip_json="${tooltip//$'\n'/\\n}"

printf '{"text":"%s","tooltip":"%s","class":"netspeed"}\n' "$text" "$tooltip_json"
