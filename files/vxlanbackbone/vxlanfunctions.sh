#!/bin/bash
# Funtions to be used in vxlan startup and check scripts

# Function to check if vxlan interface is already running
is_vx_running() {
    if [ ! -f "/sys/class/net/$1/operstate" ];then
       echo "$1 not up yet"
       return 1
    else
       cat /sys/class/net/$1/operstate | grep -q -v UNKNOWN > /dev/null || return $?
    fi
}

# Function to check if vxlan interface is already added to batman-adv interface
is_vx_added_to_bat() {
    if ! /usr/local/sbin/batctl if | grep -q "$1: active";then
       return 1
    else
       return 0
    fi
}

# Function to check if vxlan interface link is up
is_vx_link_up() {
    if ip a show dev $1 | grep -q "state DOWN";then
       return 1
    else
       return 0
    fi
}

#Function that returns true if any of the other functions return false
any_vx_problem() {
   local vxlanstatus=0
   if ! is_vx_running "$1"; then
      vxlanstatus=1
   fi
   if ! is_vx_added_to_bat "$1"; then
      vxlanstatus=1
   fi
   if ! is_vx_link_up "$1"; then
      vxlanstatus=1
   fi
   if (($vxlanstatus == 1)); then
      return 0
   else
      return 1
   fi
}
