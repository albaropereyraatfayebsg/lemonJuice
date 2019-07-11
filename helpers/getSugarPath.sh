#! /bin/sh -
if [ "X-h" = "X$1" ];
then
  printf "Help stuff";
elif [ -z "$1" ];
then
  printf "Enter the name of the directory you woud like to get the Sugar path for: ";
  read dir;
else
  dir="$1";
fi

sitePath=$(sh ${0%/*}/getSitePath.sh "$dir");

# Get Sugar directory
if [ -f "$sitePath/sugar_version.json" ];
then
  sugarPath="$sitePath";
elif [ -f "$sitePath/crm/sugar_version.json" ];
  then
   sugarPath="$sitePath/crm";
else
  logger -s "This is not a Sugar directory.";
  exit 1;
fi

printf "%s\n" "$sugarPath";
