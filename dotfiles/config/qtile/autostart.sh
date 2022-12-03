#!/usr/bin/env bash

/usr/lib/notification-daemon-1.0/notification-daemon &
/usr/lib/kdeconnectd &

orca &
firefox --private-window &
