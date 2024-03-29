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


#########################################
# link_dar function creates symlinks to
# files of a dar archive with another 
# basename
# $1 : basename of the existing archive
# $2 : basename of links
#########################################
function link_dar()
{
    target=$(echo $1|sed 's/^.*\///')
    if [ -f $2.1.dar ]; then
        warning "The symlink $2.1.dar already exists!"
    else
        ln -s $target.1.dar $2.1.dar
    fi
    if [ -f $2.lst ]; then
        warning "The symlink $2.lst already exists!"
    else
        ln -s $target.lst $2.lst
    fi

    if [ ! -d $trashdir ]; then
        mkdir $trashdir
    fi
    echo "$2" >> $trashdir/links
}



function create_list_file()
{
    echo $1 > $datadir/$1.lst
}

function append_list_file()
{
    cp $datadir/$1.lst $datadir/$2.lst
    echo $2 >> $datadir/$2.lst
}

function clear_trash()
{
    if [ ! -d $trashdir ]; then
        return
    fi

    #if trash is empty do nothing
    ls $trashdir/* > /dev/null || return 0
        
    count=$n_trash
    while [ $count -gt 0 ]; do
        let count_next=$count-1 || count_next=0
        if [ -d $trashdir.$count_next ]; then
            mv $trashdir.$count_next $trashdir.$count
        fi
        count=$count_next
    done
    mv $trashdir $trashdir.1
    mkdir $trashdir
    if [ -d $trashdir.$n_trash ];then
        rm -Rf $trashdir.$n_trash
    fi
}

function rm_file()
{
    if [ ! -d $trashdir ]; then
        mkdir $trashdir
    fi

    if [ ! -f $1 ]; then
        warning "File $1 already removed"
    else
        mv $1 $trashdir/
    fi
}

function rm_files()
{
    if [ ! -d $trashdir ]; then
        mkdir $trashdir
    fi

    if ls $@ > .ls.tmp 2> .err.tmp; then
        mv $@ $trashdir/
    else
        errnum=$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 8)
        warning "Some files already removed. See warn.$errnum"
        mv .err.tmp warn.$errnum

        RM_FILES=$(cat .ls.tmp)
        if [ ! -z "$RM_FILES" ]; then
            mv $RM_FILES $trashdir/
        fi
    fi
}

function tmp_backup()
{
    if [ ! -d $trashdir ]; then
        mkdir $trashdir
    fi

    cp -a $1 $trashdir/
}

function lock()
{
    if [ -f $lockfile ]; then
        error "Previous sync not ended properly!"
    fi
    echo 'YEAR='$year > $tmpdatafile
    echo 'MONTH='$month >> $tmpdatafile
    echo 'WEEK='$week >> $tmpdatafile
    echo 'DAY='$day >> $tmpdatafile
    echo 'INFO=""' >> $tmpdatafile
    mv $tmpdatafile $lockfile
}

function lock_info()
{
    echo "INFO+=' '$1" >> $lockfile
}

function lock_name()
{
    echo "NAME=$1" >> $lockfile
}

function unlock()
{
    rm_file $lockfile
}

function get_year()
{
    if [ -n "$fakeyear" ]; then
        echo "$fakeyear"
    else
        date "+%y"
    fi
}

function get_month()
{
    if [ -n "$fakemonth" ]; then
        echo "$fakemonth"
    else
        date "+%m"
    fi
}

function get_day()
{
    if [ -n "$fakeday" ]; then
        echo "$fakeday"
    else
        date "+%d"
    fi
}

