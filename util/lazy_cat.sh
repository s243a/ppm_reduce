#!/bin/bash
set -x
cd "$(dirname "$0")"
source ./ppm-reduce-functions
  tmp_pipe="$(realpath .)/$(mktemp -u tmppipeXXXX)"
  mkfifo "$tmp_pipe"
  nohup bash -c "cat \"$@\" >\"$tmp_pipe\"" &>/dev/null &
  echo "$tmp_pipe"
  exec 1>/dev/null
