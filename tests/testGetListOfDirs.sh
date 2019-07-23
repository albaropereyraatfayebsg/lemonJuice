#! /bin/sh -

httpdRootDir=$(sh ${0%/*}/../helpers/getHttpdRootDir.sh);

listOfDirs=$(sh ${0%/*}/../helpers/getListOfDirs.sh);

# Searching for a known directory inside Sugar to determine if the depth is accurate.
if printf "%s" "$listOfDirs" | grep "modules/Accounts" > /dev/null 2>&1;
then
  printf "You might have to change the find depts in %sgetListOfDirs.sh\n" "${0%/*}/../helpers/";
  printf "to accurately get the diretories you are looking for.\n";
  printf "Test failed.\n";
  exit 1;
fi

