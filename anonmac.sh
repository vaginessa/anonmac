#!/bin/bash

## Anonmac Copyright 2013, rfarage (rfarage@yandex.com)
#
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
#
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License at (http://www.gnu.org/licenses/) for
## more details.

fhelp()
{
  clear
  echo """
anonmac - Change mac addresses

Examples: 
         anonmac -i wlan0   ~  Change wlan0 mac address
         anonmac            ~  Change all interface mac addresses
"""
exit
}
COLOR='tput setab'
if [ $1 -z ] 2> /dev/null
  then
	NICS="$(ifconfig | grep 'Link encap'  | cut -d ' ' -f 1)"
    if [ $1 = "-h" ] 2> /dev/null
      then
        fhelp
    fi
  else
    NICS=$2
fi
for NIC in $NICS
  do
	if [ $(echo "$NIC" | grep lo) -z  ] 2> /dev/null
		then
			ifconfig $NIC down
			$COLOR 2;echo " [*] $NIC MAC address changed! [*]";$COLOR 9 
			macchanger -a $NIC | grep Current -A 2
			ifconfig $NIC up
	fi
  done
