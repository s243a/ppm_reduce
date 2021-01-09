#!/bin/bash
set -x
cd "$(dirname "$0")"
source ./ppm-reduce-functions
  tmp_pipe="$(realpath .)/$(mktemp -u tmppipeXXXX)"
  mkfifo "$tmp_pipe"
  nohup bash -c "cat \"$@\"; sleep 100; rm  \"$tmp_pipe\""  $1 >$tmp_pipe &
  echo "$tmp_pipe"
  exec 1>/dev/null
