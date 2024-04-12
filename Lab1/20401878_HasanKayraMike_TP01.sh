#!/bin/bash

# 1.1
wget https://burakarslan.com/inf333/tp/tp1.tar.gz

# 1.2
mkdir tp1
cd tp1

# 1.3
tar -xvzf ../tp1.tar.gz -C ../tp1

# 1.4
ls -l

# 1.5
# Each file is of size 128 bytes, let's count the number of files and multiply by 128
ls | wc -l
# There are 100 files; therefore, the total size should be 12800 bytes; let's verify
du -b
# The actual size is different from the interpreted one. This is because the files are stored in allocated memory blocks and not all blocks are full.

# 1.6
mkdir {1..9}

# 1.7
mv 1*.bin 1
mv 2*.bin 2
mv 3*.bin 3
mv 4*.bin 4
mv 5*.bin 5
mv 6*.bin 6
mv 7*.bin 7
mv 8*.bin 8
mv 9*.bin 9

# 1.8
ls 1
ls 2
ls 3
ls 4
ls 5
ls 6
ls 7
ls 8
ls 9

# 1.9
chmod -x *

# 1.10
ls 1
ls 2
ls 3
ls 4
ls 5
ls 6
ls 7
ls 8
ls 9
# ls commands still show the contents of given directories but it also gives out permission denied error messages
# This is the result of ls trying to access the files while also reading them. Since the executable bits are removed,
# ls isn't able to access the files, hence the permission denied error.

# 1.11
chmod +x *

# 1.12
mv ./*/* .
rmdir {1..9}

# 1.13
du -b
# The results are the same.

