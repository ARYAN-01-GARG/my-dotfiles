# Script for Random Wallpaper ( CTRL ALT W)

PICTURES_DIR="$(xdg-user-dir PICTURES 2>/dev/null || echo "$HOME/Pictures")"
wallDIR="$PICTURES_DIR/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
all_monitors=($(hyprctl monitors -j | jq -r '.[].name'))

PICS=($(find -L "${wallDIR}" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.pnm" -o -name "*.tga" -o -name "*.tiff" -o -name "*.webp" -o -name "*.bmp" -o -name "*.farbfeld" -o -name "*.gif" \)))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}


# Transition config
FPS=30
TYPE="random"
DURATION=1
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Ensure daemon is running
awww query > /dev/null 2>&1 || awww-daemon --format xrgb && sleep 1

# Set wallpaper on every connected monitor
for monitor in "${all_monitors[@]}"; do
    RAND=${PICS[ $RANDOM % ${#PICS[@]} ]}
    awww img -o "$monitor" "$RAND" $SWWW_PARAMS
done

# Run wallust for the focused monitor's wallpaper
"$SCRIPTSDIR/WallustSwww.sh" "$RANDOMPICS"

sleep 2
"$SCRIPTSDIR/Refresh.sh"

