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

cd device/htc/m7-common
HEAD=${get_out_head}
pstest 14130
pstest 14091
cd $ROOT

cd frameworks/base
HEAD=${get_our_head}
pstest 14068
pstest 14069
pstest 14081
cd $ROOT

cd packages/apps/Settings
HEAD=${get_our_head}
pstest 14066
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
