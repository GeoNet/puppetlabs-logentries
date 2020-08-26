#!/bin/sh

if [ -s /usr/bin/le2 ]; then
  if [ -s /etc/le/token ]; then
    # Use /etc/le/token file to manually set a logentries token
    # and its content should be like this
    # le_rsyslog_token=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx
    cat /etc/le/token
  else
    /usr/bin/le2 tokens
  fi
fi
