_humble() {
  if [[ -f "${_gamedir}/${_archive}" ]]; then
    ln -sf "${_gamedir}/${_archive}"
  fi

  if [ ! -f "${_archive}" ]; then
    for bundle in ${_bundle[@]}; do
      case ${bundle} in
        "humblebundle"*) _key="_humblebundle${bundle:12}key";;
        *) continue;;
      esac
      if [ -n "${!_key}" ]; then
        msg2 "Getting your unique ${pkgname} download location."
        _uri="$(curl -s "http://www.humblebundle.com/downloads?key=${!_key}" | grep "${_archive}" | cut -d "'" -f 10)"
        wget $_uri
        mv ${_archive}* ${_archive}
        break
      fi
    done
    if [ -z "${!_key}" -a ! -f "${startdir}/${_archive}" ]; then
      error "Unable to find \"${_archive}\"." 
      plain "You should run one of these commands before installing this pkg."
      for bundle in ${_bundle[@]}; do
        plain "$ export _${bundle}key=<your-${bundle}-key>"
      done
      plain "$ export _gamedir=<dir/to/${_archive}>"
      exit 1
    fi
  fi
  if ! echo "${_archive_md5}  ${_archive}" | md5sum -c --quiet; then
    echo "Invalid checksum for ${_archive}"
    return 1
  fi
  unset _key _uri _archive_md5 _bundle
}
