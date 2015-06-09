#!/bin/bash

user=$(whoami)
if [ "$user" != "root" ]; then
   echo "You must be root for execute this script"
   exit 1;
fi

# Obtain operating system
centos=$(cat /etc/issue | grep CentOS |grep 6| wc -l)

# Install needed repositories
if [ $centos -eq 1 ]; then
	echo "Operating System Centos 6.x"
	yum localinstall http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
	
else
	echo "Operating System Fedora or Centos 7.x"
	yum localinstall http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
	yum localinstall http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
fi	

# Install Needed Dependencies
yum install -y alsa-lib.i686 fontconfig.i686 freetype.i686 glib2.i686 libSM.i686 libXScrnSaver.i686 \
            libXi.i686 libXrandr.i686 libXrender.i686 libXv.i686 libstdc++.i686 pulseaudio-libs.i686\
            qt.i686 qt-x11.i686 zlib.i686 qtwebkit.i686 

if [ $centos -eq 1]; then
	yum install -y libcanberra-gtk2.i686 gtk2-engines.i686 PackageKit-gtk-module.i686
fi	

# Download Skype 4.3 Dynamic

cd /tmp
 
	## Skype 4.3 Dynamic for Fedora/CentOS/RHEL/SL ##
wget --trust-server-names http://www.skype.com/go/getskype-linux-dynamic

# Extract Skype
mkdir /opt/skype
 
	## Extract Skype 4.3 ##
tar xvf skype-4.3* -C /opt/skype --strip-components=1

# Create Launcher
ln -s /opt/skype/skype.desktop /usr/share/applications/skype.desktop
ln -s /opt/skype/icons/SkypeBlue_48x48.png /usr/share/icons/skype.png
ln -s /opt/skype/icons/SkypeBlue_48x48.png /usr/share/pixmaps/skype.png
 
touch /usr/bin/skype
chmod 755 /usr/bin/skype

if [ $centos -eq 1 ]; then
	export SKYPE_HOME="/opt/skype"
	export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc"
	$SKYPE_HOME/skype --resources=$SKYPE_HOME $*

	cat << EOF > /usr/bin/skype
		#!/bin/sh
		export SKYPE_HOME="/opt/skype"
		export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc"
		 
		\$SKYPE_HOME/skype --resources=\$SKYPE_HOME \$*
	EOF
else
	export SKYPE_HOME="/opt/skype"
	$SKYPE_HOME/skype --resources=$SKYPE_HOME $*
	cat << EOF > /usr/bin/skype
		#!/bin/sh
		export SKYPE_HOME="/opt/skype"
 
		\$SKYPE_HOME/skype --resources=\$SKYPE_HOME \$*
	EOF
fi