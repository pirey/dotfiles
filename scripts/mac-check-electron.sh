#!/bin/zsh

LATEST_SUPPORTED_VERSION=30
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

mdfind "kind:app" 2>/dev/null | sort -u | while IFS= read -r app; do
  bin="$app/Contents/Frameworks/Electron Framework.framework/Electron Framework"

  [[ -f "$bin" ]] || continue

  appname="${app##*/}"

  electronVersion=$(
    strings "$bin" |
      grep -E 'Electron/[0-9]+' |
      grep -v '%s' |
      sort -u |
      head -n1 |
      cut -d/ -f2
  )

  [[ -n "$electronVersion" ]] || continue

  major="${electronVersion%%.*}"

  if [[ "$major" -lt "$LATEST_SUPPORTED_VERSION" ]]; then
    printf "App Name:          ${RED}%s${NC}\n" "$appname"
  else
    printf "App Name:          ${GREEN}%s${NC}\n" "$appname"
  fi

  printf "Electron Version:  %s\n" "$electronVersion"
  printf "Path:              %s\n\n" "$app"
done

