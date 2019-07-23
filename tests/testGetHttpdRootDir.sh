#! /bin/sh -

httpdRootDir=$(sh ${0%/*}/../helpers/getHttpdRootDir.sh);

if [ -z "${httpdRootDir##/*}" ];
then
  printf "The absolute path starts with / like any other path.\n";
else
  printf "Absolute path test failed the path does not start with /\n";
  exit 1;
fi
