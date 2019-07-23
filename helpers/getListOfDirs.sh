#! /bin/sh -

if [ "X-h" = "X$1" ];
then
  cat <<EOF
Help stuff
EOF

fi
findDepth=2;
httpdRootDir=$(sh ${0%/*}/getHttpdRootDir.sh);
dir=$1

if [ -z "$dir" ];
then
  findCommand="sudo find ${httpdRootDir} -mindepth 2 -maxdepth ${findDepth} -type d -print";
else
  findCommand="sudo find ${httpdRootDir} -mindepth 2 -maxdepth ${findDepth} -type d -name *${dir}* -print";
fi

sitePath=$($findCommand);

if [ -z "$sitePath" ];
then
  printf "The directory you entered %s does not exist.\n" "$dir" >&2&
  exit 1;
else
  printf "%s" "$(printf "${sitePath}" | sed "s/$(sh ${0%/*}/getHttpdRootDir.sh -e)\///g")";
fi
