#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
#/ Usage: ./build.sh [PLATFORM]...
#/
#/   Build the specified Docker images and test the installation.
#/
#/ EXAMPLES
#/  ./build.sh
#/     prints this help message
#/  ./build.sh centos/7/
#/     builds the Docker image for CentOS 7
#/  ./build.sh fedora/*
#/     builds all available images for Fedora
#/  ./build.sh all
#/     builds all available images


#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
readonly script_name=$(basename "${0}")
readonly script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)

# Color definitions
readonly reset='\e[0m'
readonly cyan='\e[0;36m'
readonly red='\e[0;31m'
readonly yellow='\e[0;33m'
# Debug info ('on' to enable)
readonly debug='on'

readonly logfile='build.log'

#}}}

main() {
  check_args "${@}"
  truncate_log
  build_images "${@}"

}

#{{{ Helper functions

build_images() {
  if [ "${1}" = "all" ]; then
    images=( */* )    # enumerate all directories
  else
    images=( ${@} )   # only directories specified on the command line
  fi

  for image in "${images[@]}"; do
    build_image "${image}"
  done
}

build_image() {
  local image="${1%/}" # Directory name with trailing / stripped
  local distribution="${image%%/*}"
  local version="${image##*/}"

  info "Building ${image}, distro ${distribution}, version ${version}"

  docker build \
    --tag="ansible-testing:${distribution}_${version}" \
    "${image}" | tee --append "${logfile}"

}

truncate_log() {
  printf '' >| "${logfile}"
}

# Check if command line arguments are valid
check_args() {
  if [ "${#}" -eq '0' ]; then
    usage
    exit 0
  fi
}

# Usage: info [ARG]...
#
# Prints all arguments on the standard output stream
info() {
  printf "${yellow}>>> %s${reset}\n" "${*}" | tee --append "${logfile}"
}

# Usage: debug [ARG]...
#
# Prints all arguments on the standard output stream,
# if debug output is enabled
debug() {
  [ "${debug}" != 'on' ] || \
    printf "${cyan}### %s${reset}\n" "${*}" | tee --append "${logfile}"
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf "${red}!!! %s${reset}\n" "${*}" 1>&2 | tee --append "${logfile}"
}

# Print usage message on stdout by parsing start of script comments
usage() {
  grep '^#/' "${script_dir}/${script_name}" | sed 's/^#\/\w*//'
}

#}}}

main "${@}"

