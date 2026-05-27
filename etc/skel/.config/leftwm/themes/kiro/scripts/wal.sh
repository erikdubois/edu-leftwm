#!/usr/bin/env bash


### Check if python-pywal is installed
### Check if dir exists and copy the template in its proper place
if [ -x "$(command -v wal)" ]; then
  if [ ! -d $HOME/.config/wal/templates ] ; then
    mkdir $HOME/.config/wal/templates &&
    cp $HOME/.config/leftwm/themes/current/template-wal/color.leftwm-theme.toml  $HOME/.config/wal/templates
  elif
    [ ! -f $HOME/.config/wal/templates/color.leftwm-theme.toml ] ; then
        cp -f $HOME/.config/leftwm/themes/current/template-wal/color.leftwm-theme.toml  $HOME/.config/wal/templates
  fi
    my_array=($HOME/.config/leftwm/themes/current/backgrounds/*)
        ####my_array=(/usr/share/backgrounds/*)

    # First login shows the Kiro default wallpaper so every fresh install opens
    # on the same branded image; afterwards rotate randomly through the set.
    first_run_marker="$HOME/.cache/kiro-first-wallpaper-done"
    default_wallpaper="$HOME/.config/leftwm/themes/kiro/backgrounds/wallhaven-1ko2rv.png"
    if [ ! -f "$first_run_marker" ] && [ -f "$default_wallpaper" ]; then
      wallpaper="$default_wallpaper"
      touch "$first_run_marker"
    else
      wallpaper="${my_array[$(( RANDOM % ${#my_array[@]} ))]}"
    fi
    wal -i "$wallpaper" -a 80
    cat ~/.cache/wal/color.leftwm-theme.toml &&
    ####bat ~/.cache/wal/color.leftwm-theme.ron &&               
    cp -f ~/.cache/wal/color.leftwm-theme.toml $HOME/.config/leftwm/themes/current/theme.toml &&
    
    leftwm command "LoadTheme $HOME/.config/leftwm/themes/current/theme.toml"

else

  # Set background
  if [ -x "$(command -v feh)" ]; then
    feh --randomize --bg-fill $HOME/.config/leftwm/themes/current/backgrounds/*
  fi
fi
