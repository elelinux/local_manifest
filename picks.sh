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

# In order to use pstest must be in build environment
. build/envsetup.sh >/dev/null 2>&1

if [ "$DIE_REF" == "--resume" ]; then
	# continue through the paces
elif [ "$DIE_REF" == "--abort" ]; then
	# abort! abort! abort!
	git reset --hard
	cd $ROOT
	exit 0;
fi
echo "Which filter to be used for picks [default: No filter<enter>]"
read FILTER

if [ "$FILTER" = "" ]; then

cd device/htc/m7-common
HEAD=${get_our_head}
pstest 13512/2
verify_clean_pick $HEAD
pstest 13514/4
verify_clean_pick $HEAD
pstest 13518/1
verify_clean_pick $HEAD
pstest 13519/1
verify_clean_pick $HEAD
cd $ROOT

cd frameworks/base
HEAD=${get_our_head}
pstest 13505/1
verify_clean_pick $HEAD
pstest 13506/1
verify_clean_pick $HEAD
pstest 13507/1
verify_clean_pick $HEAD
pstest 13508/1
verify_clean_pick $HEAD
pstest 13509/1
verify_clean_pick $HEAD
cd $ROOT

cd frameworks/native
HEAD=${get_our_head}
pstest 13488/1
verify_clean_pick $HEAD
cd $ROOT

cd hardware/libhardware
HEAD=${get_our_head}
pstest 13515/1
verify_clean_pick $HEAD
pstest 13516/1
verify_clean_pick $HEAD
pstest 13517/1
verify_clean_pick $HEAD
cd $ROOT

cd hardware/libhardware_legacy
HEAD=${get_our_head}
pstest 13526/1
verify_clean_pick $HEAD
pstest 13527/1
verify_clean_pick $HEAD
pstest 13528/1
verify_clean_pick $HEAD
pstest 13529/1
verify_clean_pick $HEAD
pstest 13530/1
verify_clean_pick $HEAD
pstest 13531/1
verify_clean_pick $HEAD
pstest 13532/1
verify_clean_pick $HEAD
pstest 13533/1
verify_clean_pick $HEAD
pstest 13534/1
verify_clean_pick $HEAD
cd $ROOT

cd hardware/qcom/display-caf
OUR_HEAD=${get_our_head}
pstest 13501/2
verify_clean_pick $HEAD
cd $ROOT

cd packages/apps/Settings
OUR_HEAD=${get_our_head}
pstest 13524/1
verify_clean_pick $HEAD
pstest 13535/1
verify_clean_pick $HEAD
pstest 13536/1
verify_clean_pick $HEAD
cd $ROOT

cd vendor/aokp
OUR_HEAD=${get_our_head}
pstest 13537/1
verify_clean_pick $HEAD
cd $ROOT

fi
