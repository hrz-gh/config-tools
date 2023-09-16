#!/bin/bash
LNX=`pwd`
cd $LNX
echo "The number of arguments is: $#"
echo "The arguments are:"
if [ -f cscope.files ];then
    rm cscope.files
fi

exclude_path=""
for arg in "$@"; do
  exclude_path="$exclude_path ! -path \"$LNX/$arg/*\""
done


find $LNX $exclude_path -name "*.c" \
    -o $exclude_path -name "*.h" \
    -o $exclude_path -name "*.cpp"> cscope.files


