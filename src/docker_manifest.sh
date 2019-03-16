#!/bin/bash


[ ! -z "$DEBUG" ] && set -x


mkdir -p ~/.docker/

if [ -z "$DOCKER_LOGIN" ] ; then
	echo "Login docker non trovato nell'environment"
else
  cat << EOF > ~/.docker/config.json
{
  "experimental": "enabled",
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "$DOCKER_LOGIN"
                }
        },
        "HttpHeaders": {
                "User-Agent": "Docker-Client/17.12.1-ce (linux)"
        }
}
EOF
fi


PARSED_OPTIONS=$(getopt -n "$0"  -o t:r:c: --long "tag:,repo_name:,callback_url:"  -- "$@")
if [ $? -ne 0 ];
then
  echo "Bad options"
  exit 1
fi

eval set -- "$PARSED_OPTIONS"

while true;
do
  case "$1" in
 
    -t|--tag)
			tag=$2
      shift ;;
 
    -r|--repo_name)
      repo_name=$2
      shift ;;
 
    -c|--callback_url)
			callback_url=$2
      shift ;;
 
    --)
      break;;
  esac
  shift
done

[ -z $repo_name ] && echo "repo_name non trovato" && exit 3
[ -z $tag ] && echo "tag non trovato" && exit 3

if [ "$tag" == "latest" ] ; then
	echo "Pushato latest, lascio stare. Esco."
  exit 0
fi

rm -rf ~/.docker/manifests/*
docker manifest create $repo_name:latest $repo_name:x86_64 $repo_name:armv7hf --amend
docker manifest annotate $repo_name:latest $repo_name:armv7hf --os linux --arch arm
docker manifest  push --purge $repo_name:latest

exit 0
