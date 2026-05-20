serve:
	hugo serve

build:
	hugo build

update:
	#!/usr/bin/env bash

	# mise.toml
	latestTag="$(gh release view -R gohugoio/hugo --json tagName | jq -r .tagName)"
	version="${latestTag#v}"
	mise use --pin "hugo-extended@$version"

	file=".woodpecker/deploy.yml"
	image="ghcr.io/gohugoio/hugo"
	printf "$file before => "
	grep "$image" $file
	sed -i "s!$image:v[0-9\.]\+!$image:$latestTag!" $file
	printf "$file after => "
	grep "$image" $file
