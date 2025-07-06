#!/bin/bash

# Replace with your actual profile ID, should be something like "b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')

# Define the theme mode variable, should be 'default' for light, 'prefer-dark' for dark
THEME_MODE=$(gsettings get org.gnome.desktop.interface color-scheme)

# Define the terminal profile path
PROFILE_PATH="/org/gnome/Terminal/Legacy/Profiles:/:$PROFILE_ID/"

if [[ "$THEME_MODE" == *'dark'* ]]; then
    # Set the terminal background color to dark mode
    echo "🌙 Setting terminal colors for DARK mode"
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" use-theme-colors false
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" background-color '#171421'
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" foreground-color '#D0CFCC'
else
    # Set the terminal background color to light mode
    echo "☀️ Setting terminal colors for LIGHT mode"
    echo "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH"
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" use-theme-colors false
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" background-color '#ffffff'
    gsettings set "org.gnome.Terminal.Legacy.Profile:$PROFILE_PATH" foreground-color '#171421'
fi

# gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/Terminal/Legacy/Profiles/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ background-color '#ffffff'
