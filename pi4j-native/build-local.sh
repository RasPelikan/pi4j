#!/bin/bash
###
# #%L
# **********************************************************************
# ORGANIZATION  :  Pi4J
# PROJECT       :  Pi4J :: JNI Native Library
# FILENAME      :  build-local.sh
#
# This file is part of the Pi4J project. More information about
# this project can be found here:  http://www.pi4j.com/
# **********************************************************************
# %%
# Copyright (C) 2012 - 2015 Pi4J
# %%
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Lesser Public License for more details.
#
# You should have received a copy of the GNU General Lesser Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/lgpl-3.0.html>.
# #L%
###

echo "-------------------------------------------"
echo "BUILDING Pi4J NATIVE LIBRARY"
echo "-------------------------------------------"

# ----------------------------------
# COPY SOURCES TO TARGET FOLDER
# ----------------------------------
mkdir -p target/native
cp -R src/main/native target
cd target/native

ARCHITECTURE=$(uname -m)
echo "PLATFORM ARCH: $ARCHITECTURE"
if [[ ( "$ARCHITECTURE" = "armv7l") || ("$ARCHITECTURE" = "armv6l") ]]; then
   echo "-------------------------------------------"
   echo " -- INSTALLING PREREQUISITES ON PI"
   echo "-------------------------------------------"

   chmod +x install-prerequisites.sh
   ./install-prerequisites.sh
fi

echo "-------------------------------------------"
echo " -- BUILDING LATEST WIRINGPI"
echo "-------------------------------------------"
chmod +x wiringpi-build.sh
./wiringpi-build.sh $@

echo "-------------------------------------------"
echo " -- COMPILING LIBPI4J.SO JNI NATIVE LIBRARY"
echo "-------------------------------------------"
make clean
make all $@

echo "-------------------------------------------"
echo " -- COPYING FINAL LIBPI4J.SO TO TARGET"
echo "-------------------------------------------"
cp libpi4j.so ../libpi4j.so

echo "-------------------------------------------"
echo " -- DONE BUILDING Pi4J NATIVE LIBRARY"
echo "-------------------------------------------"
