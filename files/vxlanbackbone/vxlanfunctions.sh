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

sync_vxlan_fdb() {
    local current_fdb_endpoints expected_endpoints missing_endpoints obsolete_endpoints dst

    echo "checking FDB-entries..."

    # check current fdb entries
    current_fdb_endpoints=$(bridge fdb show dev "$vxlanifname" |
        awk '/00:00:00:00:00:00/ && /dst/ {for (i=1;i<=NF;i++) if ($i=="dst") print $(i+1)}' | sort -u)

    # expected enpoints (without own IP)
    expected_endpoints=$(printf "%s\n" "${vxlanEndpoints[@]}" | grep -v -F "$WgIp" | sort -u)

    # compare missing and obsolete endpoints
    missing_endpoints=$(comm -13 <(echo "$current_fdb_endpoints") <(echo "$expected_endpoints"))
    obsolete_endpoints=$(comm -23 <(echo "$current_fdb_endpoints") <(echo "$expected_endpoints"))

    # add missing endpoints
    for dst in $missing_endpoints; do
        echo "FDB missing for $dst , adding it"
        /sbin/bridge fdb append to 00:00:00:00:00:00 dst "$dst" dev "$vxlanifname"
    done

    # delete old endpoint fdb entries
    for dst in $obsolete_endpoints; do
        echo "FDB-entry for $dst is obsolete, deleting it"
        /sbin/bridge fdb del to 00:00:00:00:00:00 dst "$dst" dev "$vxlanifname"
    done
}
