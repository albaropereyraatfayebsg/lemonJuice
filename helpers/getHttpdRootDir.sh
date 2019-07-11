#! /bin/sh -

# TODO COMPATIBILITY
# get this from Apache for other unix flavors


# This works for ubuntu
# finds files that contain the word default and end in .conf
# looks for lines that start with white spaces '\n' and any character '*'
# followed by "DocumentRoot", removes ssl config since it is probably secondary
# Removes the file name and setting prefix, and delimiter.
# Gets the first value, just in case there are duplicates or something awkward is going on
httpdRootDir=$(grep "^\s*DocumentRoot" $(find /etc/apache2 -name '*default*.conf') | grep -v "ssl" | sed 's/^.*DocumentRoot\s//g' | head -1;);

if [ "X-h" = "X$1" ];
then
  printf "This script prints the httpd DocumentRoot. Notce, it only gathers\n";
  printf "Default values and rejects ssl configs to get what is mostlikely\n";
  printf "the most accurate value.\n";
  printf " -e Use the e option for escaped root httpd directory.\n";
elif [ "X-e" = "X$1" ];
then
  escapedHttpdRootDir=$(printf "%s" "$httpdRootDir" | sed 's/\//\\\//g');
  printf "%s\n" "$escapedHttpdRootDir";
else
  printf "%s\n" "$httpdRootDir";
fi
