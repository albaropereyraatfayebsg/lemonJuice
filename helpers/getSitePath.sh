#! /bin/sh -
if [ "X-h" = "X$1" ];
then
  printf "Help stuff";
elif [ -z "$1" ];
then
  printf "Enter the name of the directory you woud like to get the site patht for: ";
  read dir;
else
  dir="$1";
fi

httpdRootDir=$(sh ${0%/*}/getHttpdRootDir.sh);
sitePath=$(sudo find ${httpdRootDir} -maxdepth 2 -type d -name ${dir} -print);
if [ -z "$sitePath" ];
then
  logger -s "The directory you entered: $dir does not exist.";
  exit 1;
else
  printf "$sitePath";
fi
