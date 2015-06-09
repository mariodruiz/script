#!/bin/bash

user=$(whoami)
if [ "$user" != "root" ]; then
   echo "You must be root for execute this script"
   exit 1;
fi

cd /tmp/
# Step 1. Download [ http://www.sublimetext.com/ ]
wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x64.tar.bz2

# Step 2. Extract Sublime package
tar -vxjf sublime_text_3_build_3059_x64.tar.bz2 -C /opt

# Step 3. Make a symbolic link to the installed Sublime3
ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime

# Step 4. Run Sublime if it is installed correctly
sublime

# Step 5. Create Gnome desktop launcher
tee /usr/share/applications/sublime3.desktop <<EOF
[Desktop Entry]
Name=Sublime
Exec=sublime
Terminal=false
Icon=/opt/sublime_text_3/Icon/48x48/sublime-text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow
 
[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
