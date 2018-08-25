#!/bin/bash
#Created by Sam Gleske
#Sat Aug 25 02:40:02 PDT 2018

IMAGE_ORDER=(
  alpine
  centos7
  centos7-android
  centos7-dnd
  ubuntu1604
  ubuntu1804
)

set -ex

if [ -z "${1:-}" ]; then
  for x in "${IMAGE_ORDER[@]}"; do
    docker build -t jervis-"$x" "$x"
  done
else
  for x in "$@"; do
    docker build -t jervis-"${x%/}" "$x"
  done
fi
