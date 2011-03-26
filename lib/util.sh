
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

