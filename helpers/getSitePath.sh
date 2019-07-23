#! /bin/sh -
if [ "X-h" = "X$1" ];
then
  cat <<EOF
Help stuff
EOF

elif [ -z "$1" ];
then
  while
  printf "Enter the name of the directory you woud like to get the site patht for: ";
  read dir;
  [ -z "$dir" ]
  do :; done;
else
  dir="$1";
fi

# vars
findDepth=2;

httpdRootDir=$(sh ${0%/*}/getHttpdRootDir.sh);
sitePath=$(sudo find ${httpdRootDir} -maxdepth $findDepth -type d -name ${dir} -print);

if [ -z "$sitePath" ];
then
  logger -s "The directory you entered: $dir does not exist.";
  exit 1;
else
  printf "$sitePath";
fi
