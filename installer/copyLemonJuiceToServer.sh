#! /bin/sh -
if [ "X$1" = "X-h" ];
then
  printf "Help stuff.\n";
elif [ -z "$1" ];
then
     printf "Enter severname: ";
     read server;
else
  server=$1;
fi
scp -r /opt/lemonJuice $server:/opt/
