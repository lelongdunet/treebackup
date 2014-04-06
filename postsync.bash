# This file is part of the treebackup project
# Copyright (C) 2012-2014  Adrien LELONG
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

shdir=`echo $0|sed -e 's/\/[^\/]*$//'`
echo "cd to $shdir"
cd "$shdir"
cd ..

PROFILE=$1

if [ -f .setup.$PROFILE ]; then
    rm .setup.$PROFILE
fi

export TB_REPLICA="true"
source ./bin/treebackup $PROFILE postsync

