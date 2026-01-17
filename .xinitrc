setxkbmap -model pc104 -layout us,ru -variant qwerty -option grp:caps_toggle

while true; do
   xsetroot -name "$( date +"%F %R" )"
   sleep 1m    # Update time every minute
done &

exec dwm
