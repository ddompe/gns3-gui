#!/bin/bash
#
# Copyright (C) 2015 GNS3 Technologies Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


set -e

SIP=4.16.8
PYQT=5.4.2

echo "Install sip $SIP and PyQT $PYQT"

mkdir -p build
cd build

# install SIP
if [ ! -d "sip-${SIP}" ]
then
    wget --quiet --output-document=sip.tar.gz "http://downloads.sourceforge.net/project/pyqt/sip/sip-${SIP}/sip-${SIP}.tar.gz"
    tar -xf sip.tar.gz
    cd "sip-${SIP}"
    echo "sip configure"
    python -B configure.py
    echo "sip make"
    make
    cd ..
fi


cd "sip-${SIP}"
echo "sip make install"
sudo make install

cd ..

echo "Install PyQT"

# install PyQt
if [ ! -d "PyQt-x11-gpl-${PYQT}" ]
then
    wget --quiet --output-document=pyqt.tar.gz "http://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-${PYQT}/PyQt-gpl-${PYQT}.tar.gz"
    tar -xf pyqt.tar.gz
    cd "PyQt-gpl-${PYQT}"
    python -B configure.py --confirm-license 
    make
    cd ..
fi

cd PyQt-x11-gpl-${PYQT}
sudo make install

python -c 'import PyQt5'  # Check if it's ok

