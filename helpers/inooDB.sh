#! /bin/sh -

file="tmp.txt";
OLDIFS=$IFS;
[ ! -f $file ] && { logger -s  "File not found."; exit 1; }

while IFS= read table
do
  echo "$table";
  sh ${0%/*}/runSQLQuery.sh quickbooks8 "ALTER TABLE $table ENGINE = InnoDB;";
done<$file
IFS=$OLDIFS;
