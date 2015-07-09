#!/bin/bash

#remove unnecessary services from baseimage runit
rm -rf /etc/service/cron/
rm -rf /etc/service/syslog-ng/
