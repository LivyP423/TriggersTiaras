#!/bin/sh
printf '\033c\033]0;%s\a' PrincessShooter
base_path="$(dirname "$(realpath "$0")")"
"$base_path/PrincessShooter.x86_64" "$@"
