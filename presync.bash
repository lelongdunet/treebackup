shdir=`echo $0|sed -e 's/\/[^\/]*$//'`
echo "cd to $shdir"
cd "$shdir"
cd ..

profile=$1
datafile=$profile.backup.dat

if [ ! -f $datafile ]; then
    touch .setup.$profile
    touch .replica.$profile
    echo "SETUP $profile"
    exit
elif [ ! -f .replica.$profile ]; then
    echo "This dir is not a replica of $profile!"
    exit 1
fi

export TB_REPLICA="true"
./bin/treebackup $profile
exit $?

