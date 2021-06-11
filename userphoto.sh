#!/bin/bash

set -e

declare -x USERNAME="$1"
declare -x USERPIC="$2"

declare -r DSIMPORT_CMD="/usr/bin/dsimport"
declare -r ID_CMD="/usr/bin/id"

declare -r MAPPINGS='0x0A 0x5C 0x3A 0x2C'
declare -r ATTRS='dsRecTypeStandard:Users 2 dsAttrTypeStandard:RecordName externalbinary:dsAttrTypeStandard:JPEGPhoto'

if [ ! -f "${USERPIC}" ]; then
  echo "User image required"
fi

# Check that the username exists - exit on error
${ID_CMD} "${USERNAME}" &>/dev/null || ( echo "User does not exist" && exit 1 )

declare -r PICIMPORT="$(mktemp /tmp/${USERNAME}_dsimport.XXXXXX)" || exit 1
printf "%s %s \n%s:%s" "${MAPPINGS}" "${ATTRS}" "${USERNAME}" "${USERPIC}" >"${PICIMPORT}"
${DSIMPORT_CMD} "${PICIMPORT}" /Local/Default M &&
    echo "Successfully imported ${USERPIC} for ${USERNAME}."

rm "${PICIMPORT}"
