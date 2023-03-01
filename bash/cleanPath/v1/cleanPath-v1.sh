#!/bin/bash

# This script would delete all the files from a specific path
# The goal is to use this scrpt with crontab to run it periodically
# and avoid filling upo the disk
# This script will be used to delete log files generated by VCC

# Version comments
# Trying some basic logging options
# For today, the path will be static, later I will add it as a variable
# Not using variables yet

rm -rf /home/testUser/test/*
if [ $? -eq 0 ]; then
  logger "SUCCESS /var/crash folder has been cleaned up. aec"
else
  logger "ERROR while deleting /var/crash folder. aec"
fi
