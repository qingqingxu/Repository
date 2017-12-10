#!/bin/bash

# 先打大文件分词大小均匀的若干个小文件，然后对小文件排好序，最后再Merge所有的小文件，在Merge的过程中去掉重复的内容
# 如果需要按行的某个字段，比如时间，排序和去重，需要特别的处理，比如在第9行和14行加上-t 和 -k参数指定分隔符和字段下标

lines=$(wc -l $1 | sed 's/ .*//g')
lines_per_file=$(expr $lines / 20)
split -d -l $lines_per_file $1 __part_$1

for file in __part_*
do
{
  sort $file > sort_$file
} &
done
wait

sort -smu sort_* > $2
rm -f __part_*
rm -f sort_*