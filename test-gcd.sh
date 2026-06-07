#!/bin/bash

# ERROR関数
ERROR_EXIT () {
  echo "$1" >&2
  rm -f /tmp/$$-*
  exit 1
}



echo "all ok"

# 後始末
rm /tmp/$$-*
