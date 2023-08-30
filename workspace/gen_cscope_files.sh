#!/bin/bash
LNX=`pwd`
cd $LNX
echo "The number of arguments is: $#"
echo "The arguments are:"
rm cscope.files
for arg in "$@"; do
    find $LNX  -name "*.h"  ! -path "$LNX/$arg/*" \
        -o -name "*.c" ! -path "$LNX/$arg/*" \
        -o -name "*.cpp"  ! -path "$LNX//tools/*" >> cscope.files
  echo "$arg"
done
exit

