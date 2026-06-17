#!/bin/bash

declare -A COLORS=(
    ["main"]="ffffff"
    ["move"]="00ccff"
)

PRIORITY=(move main)

declare -A ACTIVE
ACTIVE["main"]=1

apply_color() {
    local brightness
    brightness=$(brightnessctl -d 'asus::kbd_backlight' get 2>/dev/null || echo 0)
    [[ "$brightness" -eq 0 ]] && return

    for layer in "${PRIORITY[@]}"; do
        if [[ -n "${ACTIVE[$layer]}" ]]; then
            asusctl aura effect static -c "${COLORS[$layer]:-ffffff}"
            brightnessctl -d 'asus::kbd_backlight' set "$brightness" 2>/dev/null
            return
        fi
    done
}

keyd listen | while IFS= read -r line; do
    case "$line" in
        /*)
            layer="${line:1}"
            ACTIVE=()
            ACTIVE["$layer"]=1
            apply_color
            ;;
        +*)
            ACTIVE["${line:1}"]=1
            apply_color
            ;;
        -*)
            unset "ACTIVE[${line:1}]"
            [[ -z "${ACTIVE[*]}" ]] && ACTIVE["main"]=1
            apply_color
            ;;
    esac
done
