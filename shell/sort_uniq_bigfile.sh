#!/bin/bash
#大文件排序去重，先将大文件根据行数均分成小文件，每个小文件排序，去重

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