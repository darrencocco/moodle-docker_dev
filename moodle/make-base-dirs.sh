#!/bin/bash
# nasty portable way to the directory of this script, following symlink,
# because readlink -f not on macOS thanks stack overflow
get_basedir () {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    BASEDIR="$( cd -P "$( dirname "$SOURCE" )/" && pwd )"
}

get_basedir
source "$BASEDIR/.env"

declare -a DIRECTORIES=(
  ${MOODLE_DOCKER_WWWROOT}
  ${MOODLE_DOCKER_MOODLEDATAROOT}
  ${MOODLE_DOCKER_PHPUNITDATAROOT}
  ${MOODLE_DOCKER_BEHATDATAROOT}
  ${MOODLE_DOCKER_BEHATFAILDUMPSDATAROOT}
  ${MOODLE_DOCKER_WEBSERVERLOGS}
  ${MOODLE_DOCKER_POSTGRESDATAROOT}
)

echo "Navigating to: ${BASEDIR}/"
cd "${BASEDIR}/"

for i in ${DIRECTORIES[@]}
do
  echo "Creating $i"
  mkdir -p ${i}
done

touch ${MOODLE_DOCKER_WEBSERVERLOGS}/access.log
touch ${MOODLE_DOCKER_WEBSERVERLOGS}/error.log

cp ${BASEDIR}/config.docker-template.php ${MOODLE_DOCKER_WWWROOT}/config.php
