#!/bin/sh

PATH=${PATH}:/sbin:/usr/lib/nagios/plugins
export PATH

CURRENT=$(date '+%s')

STORAGE_OUTPUT=/etc/dataone/monitor/nagiosStorage.out
PROCESSING_OUTPUT=/etc/dataone/monitor/nagiosProcessing.out
SESSION_OUTPUT=/etc/dataone/monitor/nagiosSession.out


if [ -f $STORAGE_OUTPUT ]; then
  STORAGE_LASTMOD=$(date -r $STORAGE_OUTPUT '+%s')
  STORAGE_DIFF=$(($CURRENT - $STORAGE_LASTMOD))
else
  STORAGE_DIFF=0
fi
if [ $STORAGE_DIFF -gt 3600 ]; then
  echo 2 HZ_Membership_hzStorage - CRIT No Update to membership information for 1 hour.
else
  if [ -f $STORAGE_OUTPUT ]; then
    cat $STORAGE_OUTPUT
  else
  	echo 3 HZ_Membership_hzStorage - UNKNOWN No nagios output file found.
  fi
fi

if [ -f $PROCESSING_OUTPUT ]; then
  PROCESSING_LASTMOD=$(date -r $PROCESSING_OUTPUT '+%s')
  PROCESSING_DIFF=$(($CURRENT - $PROCESSING_LASTMOD))
else
  PROCESSING_DIFF=0
fi
if [ $PROCESSING_DIFF -gt 3600 ]; then
  echo 2 HZ_Membership_hzProcessing - CRIT No Update to membership information for 1 hour.
else
  if [ -f $PROCESSING_OUTPUT ]; then
    cat $PROCESSING_OUTPUT
  else
  	echo 3 HZ_Membership_hzProcessing - UNKNOWN No nagios output file found.
  fi
fi

if [ -f $SESSION_OUTPUT ]; then
  SESSION_LASTMOD=$(date -r $SESSION_OUTPUT '+%s')
  SESSION_DIFF=$(($CURRENT - $SESSION_LASTMOD))
else
  SESSION_DIFF=0
fi
if [ $SESSION_DIFF -gt 3600 ]; then
  echo 2 HZ_Membership_hzSession - CRIT No Update to membership information for 1 hour.
else
  if [ -f $SESSION_OUTPUT ]; then
    cat $SESSION_OUTPUT
  else
  	echo 3 HZ_Membership_hzSession - UNKNOWN No nagios output file found.
  fi
fi