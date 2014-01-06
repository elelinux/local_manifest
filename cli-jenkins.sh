#!/bin/bash
# Command-line jenkins utility
# (c) 2013 Brandon McAnsh
#set -x
gerrit=gerrit.aokp.co
remote=aokp
pass=0
device=m7tmo
function lunch_and_clean() {
        . build/envsetup.sh >/dev/null 2>&1
        echo "Select device codename (default m7tmo)"
        local devicename=$(get_device)
        lunch aokp_${devicename}-userdebug
        make clean
}

function get_device() {
        read device
        [ -z $device ] && device=m7tmo
}

function config() {
        echo " "
        echo "CLI verify config"
        echo "================="
        echo " "
        echo "Which repo (path)?"
        read repo
        directory=${repo}
        echo " "
        echo "Which commit id?"
        read commitId
        pick=${commitId}
        echo " "
        echo "Select device codename (default m7tmo)"
        get_device
}

function verify_commit() {
        populate_pick_vars
        if [ "$pass" == 1 ]; then
                message='This is an automated message. Patchset builds in current tree.'
                verify=+1
                prompt='Successful'
        else
                message='This is an automated message. Patchset fails to build in current tree.'
                verify=-1
                prompt='Failure'
        fi
        ssh gerrit gerrit review --verified $verify -m "'$message'" $commit
        echo " Commit verified -- ${prompt}."
}

function populate_pick_vars() {
        [ -z "$1" ] || pick=$1
        project=`git config --get remote.aokp.projectname`
        submission=`echo $pick | cut -f1 -d "/" | tail -c 3`
        pick=$( git ls-remote http://$gerrit/$project | grep /changes/$submission/$pick | tail -1 )
        pick=${pick#*/*/*/*}
        commit=$( echo $pick | sed 's/\//,/g' )
}

function iterate_through_file() {
        . build/envsetup.sh >/dev/null 2>&1
        message='This is an automated message. Patchset builds in current tree.'
        verify=+1
        file=$(cat $ANDROID_BUILD_TOP/.files_to_verify)
        echo "$file" | while read line; do
                if grep -q "repo:" <<< $line; then
                        dir=${line##*:}
                else
                        cd $dir
                        populate_pick_vars $line
                        echo "Verifiying ${commit}"
                        ssh gerrit gerrit review --verified $verify -m "'$message'" $commit < /dev/null
                        cd -
                fi
        done
}

# For now when using make clean setup cli manually
if [ "$1" == "-cs" ]; then
        repo sync -j50
        lunch_and_clean
        config
fi

if [ "$1" == "-auto" ]; then
        iterate_through_file
        exit 0
fi

# ============================================
# jenkins
. build/envsetup.sh >/dev/null 2>&1

if [ -z "$1" ]; then
        config
else
        # check for valid input
        re='^[0-9]+$'
        directory=$1
        pick=$2
        device=$3
        if ! [[ $pick =~ $re ]]; then
                        echo "Not a valid patch(Must be a number)."
                        cd -
                        exit 1
        fi
        if [ -z "$device" ]; then
                        echo "Select device codename (default m7tmo)"
                        get_device
        fi
fi

# Cherry-pick commit to be verified
cd $directory
pstest $pick
cd -
# Build
brunch ${device}
echo " "
# Verify build completion
echo " Checking build completion...."
cd out/target/product/${device}
[ -f aokp_${device}_*.zip ] && pass=1
cd -
cd $directory
# Verify commit
verify_commit
cd -
exit
