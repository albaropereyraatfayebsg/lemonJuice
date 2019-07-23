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

if [ -z "$2" ];
then
  printf "You must enter the name of a settng (e.g sugarFlavor, sugarVersion, dbName, etc.).\n";
  exit 1;
fi

sugarPath=$(sh ${0%/*}/getSugarPath.sh "$dir");

# Get config_overide.php file path
config_override_file_path=$(sudo find "${sugarPath}" -maxdepth 1 -type f -name 'config_override.php');

if [ "$config_override_file_path" ]; then
  include_config_override="include '${config_override_file_path}';";
fi

case $2 in
  sugarFlavor)
    # Sugar edition
    output=$(jq '.sugar_flavor' "${sugarPath}/sugar_version.json" | sed 's/"//g');
    ;;
  sugarVersion)
    # Sugar version
    output=$(jq '.sugar_version' "${sugarPath}/sugar_version.json" | sed 's/"//g');
    ;;
  dbName)
    # DB Name
    sugar_config_string="\$sugar_config['dbconfig']['db_name']";
    output=$(sudo php -r "require '${sugarPath}/config.php';${include_config_override}if(isset(${sugar_config_string})){print_r(${sugar_config_string});}");
    ;;
  username)
    # DB userName
    sugar_config_string="\$sugar_config['dbconfig']['db_user_name']";
    output=$(sudo php -r "require '${sugarPath}/config.php';${include_config_override}if(isset(${sugar_config_string})){print_r(${sugar_config_string});}");
    ;;
  password)
    sugar_config_string="\$sugar_config['dbconfig']['db_password']";
    output=$(sudo php -r "require '${sugarPath}/config.php';${include_config_override}if(isset(${sugar_config_string})){print_r(${sugar_config_string});}");
    ;;
  host)
    sugar_config_string="\$sugar_config['dbconfig']['db_host_name']";
    output=$(sudo php -r "require '${sugarPath}/config.php';${include_config_override}if(isset(${sugar_config_string})){print_r(${sugar_config_string});}");
    ;;
  *)
    printf "This setting: %s is not available.\n" "$2";
    logger "Unable to retieve setting";
    exit 1;
    ;;
esac
printf "%s\n" "$output";
