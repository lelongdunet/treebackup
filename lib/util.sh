
#########################################
# link_dar function creates symlinks to
# files of a dar archive with another 
# basename
# $1 : basename of the existing archive
# $2 : basename of links
#########################################
function link_dar()
{
    #ln -sf $1.1.dar $2.1.dar
    #ln -sf $1.lst $2.lst
    ln -s $1.1.dar $2.1.dar
    ln -s $1.lst $2.lst
    echo "$2" >> $trashdir/links
}



function create_list_file()
{
    echo $1 > $1.lst
}

function append_list_file()
{
    cp $1.lst $2.lst
    echo $2 >> $2.lst
}

function clear_trash()
{
    if [ ! -d $trashdir ]; then
        mkdir $trashdir
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
    mv $1 $trashdir/
}

function rm_files()
{
    mv $@ $trashdir/
}

function tmp_backup()
{
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


