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

function pick() {
   local array=$1
   for i in ${array[@]} do
       pstest $i
   done
}

function pick_em() {
echo "Which filter to be used for picks [default: No filter<enter>]"
read FILTER

if [ "$FILTER" = "" ]; then

declare -a m7-common=( '14130' '14091' )
declare -a fw_base=( '14068' '14069' '14081' )
declare -a settings=( '14066' )

cd device/htc/m7-common
pick m7-common
cd $ROOT

cd frameworks/base
pick fw_base
cd $ROOT

cd packages/apps/Settings
pick settings
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
