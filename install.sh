#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root" 2>&1
  exit 1
else

if [[ ! -e /usr/bin/pip ]]; then
  apt -y install python-pip
fi

python -m pip install setuptools
python -m pip install serial
python -m pip install pygame --user

if [[ -e /tmp/weatherpi-build ]]; then
  rm -rf /tmp/weatherpi-build
fi

mkdir /tmp/weatherpi-build
cd /tmp/weatherpi-build

wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/python-weather-api/pywapi-0.3.6.tar.gz
tar -zxvf pywapi-0.3.6.tar.gz
cd pywapi-0.3.6/
python setup.py build
python setup.py install

cd /tmp/weatherpi-build
wget https://cdn.instructables.com/ORIG/FAQ/7BWL/I1NULEIL/FAQ7BWLI1NULEIL.zip
unzip FAQ7BWLI1NULEIL.zip
cd Weather/

python weather.py

fi
