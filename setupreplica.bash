shdir=`echo $0|sed -e 's/\/[^\/]*$//'`
echo "cd to $shdir"
cd "$shdir"
cd ..

profile=$1

touch .replica.$profile
mkdir data || echo data already created.

