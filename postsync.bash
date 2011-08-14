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

