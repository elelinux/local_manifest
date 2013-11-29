# symlinked from local_manifest repo
# Run from root of source tree

# Initialize helper functions
. helper_functions

# Set null value for filter
FILTER=

# Set die ref
DIE_REF=$1

function filter_list {
	echo " Current filters:"
	echo "-----------------"
	echo " No filter <enter>"
	FILTER=bullshit
	exit 0
}

function pick_em() {
echo "Which filter to be used for picks [default: No filter<enter>]"
read FILTER

if [ "$FILTER" = "" ]; then

cd build
#Update pstest
HEAD=${get_our_head}
pstest 13548/2
verify_clean_pick $HEAD
cd $ROOT

# Reinitialize with updated pstest
. build/envsetup.sh >/dev/null 2>&1

cd build
pstest 13607
verify_clean_pick $HEAD
cd $ROOT

cd frameworks/base

pstest 13546
verify_clean_pick $HEAD

cd packages/apps/Settings
HEAD=${get_our_head}
pstest 13535
verify_clean_pick $HEAD
pstest 13536
verify_clean_pick $HEAD
cd $ROOT

fi

}

# In order to use pstest must be in build environment
. build/envsetup.sh >/dev/null 2>&1

if [ "$DIE_REF" == "--resume" ]; then
        # continue through the paces
        pick_em
elif [ "$DIE_REF" == "--abort" ]; then
        # abort! abort! abort!
        git reset --hard
        cd $ROOT
        exit 0;
else
        pick_em
fi
