#! /bin/sh -

if [ "X-h" = "X$1" ];
then
  cat <<EOF
Help stuff
EOF
elif [ -z "$1" ];
then
  while
  printf "Enter the name of the directory you woud like to get the Sugar settings for: ";
  read dir;
  [ -z "$dir" ]
  do :; done;
else
  dir="$1";
fi

# Just look for the next value
if [ -z "$2" ];
then
  printf "You must enter a query (ex SELECT * FROM foo WHERE bar =\\\"string\\\";): \n";
  exit 1;
else
  # get rid of current $1
  shift;
  sqlQuery="$*";
fi

tmpFile=".tmp.cnf";

host=$(sh ${0%/*}/getSugarSettings.sh "$dir" "host");
dbName=$(sh ${0%/*}/getSugarSettings.sh "$dir" "dbName");
username=$(sh ${0%/*}/getSugarSettings.sh "$dir" "username");
password=$(sh ${0%/*}/getSugarSettings.sh "$dir" "password");

if [ "$host" ] && [ "$dbName" ] && [ "$username" ] && [ "password" ];
then
  
  oldUmask=$(umask -S);
  umask 0377;
  tee <<EOF >"$tmpFile"
[client]
user = $username
password = $password
host = $host
EOF
  umask $oldUmask;
  # Note: -Be 'B' Removes output formating 's' Removes header 'e' Executes commands seperated by ';'
  result=$(mysql --defaults-extra-file=$tmpFile ${dbName} -e "${sqlQuery}" 2> /dev/null);

  if [ -z "${result}" ];
  then
    logger -s "An error occured when we tried to query the DB."&
 fi
else
  logger -s "We need more information to connect to the DB."&
fi
  
rm -rf "$tmpFile";
