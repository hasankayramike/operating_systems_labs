#!/bin/bash


wget https://burakarslan.com/inf333/tp/tp1.tar.gz
mkdir tp2
cd tp2
tar -xvzf ../tp1.tar.gz -C ../tp2
echo "files extracted"
echo "###################"
echo "num of files:"
ls -1 | wc -l
echo "###################"
echo "hash of the files:"
ls -1 | sha256sum
echo "###################"
echo "total size in bytes:"
du --bytes 

# used "164.bin" as an example file
stats=$(stat ./164.bin)
echo "###################"
echo "deduplication started, this may take a while!"

#1.1
declare -A checksums

for i in *.bin; do
    i_sha=$(sha256sum $i | cut -d ' ' -f1)
    
    if [[ -n ${checksums[$i_sha]} ]]; then
        ln -f ${checksums[$i_sha]} $i;
    else
        checksums[$i_sha]=$i;
    fi;
done;

echo "###################"	
echo "deduplication completed"


#1.2
stats2=$(stat ./164.bin)
echo "###################"
echo "stat before:"
echo "$stats"
echo "###################"
echo "stat after:"
echo "$stats2"

# The difference between the stat outputs are
# The inode and the links
# The inode number changed from "2105263" to "2105213"
# And this inode number is now linked to 10 files, instead of 1 as before.
# Inodes are essentially the entries on the storage
# And files are pointers to these inodes.
# If two files have the same inode number,
# They point to the same space on the drive.
# In this case, the inode number changed because we hardlinked
# This file with another file of same sha256sum, thus the same content.
# 164.bin is, seemingly, identical with 9 other files
# And we hard linked all 10 of them together to point to the inode 2105213,
# Which was the inital inode number of one of those 10 files.
# This method didn't remove redundant files, instead, grouped them into unique inode numbers
# So that they don't take additional space for the same data.
# This is useful for preventing unwanted "rm"s.  


echo "###################"
echo "num of files:"
ls -1 | wc -l
echo "hash of the files:"
ls -1 | sha256sum
echo "total size in bytes:"
du --bytes


