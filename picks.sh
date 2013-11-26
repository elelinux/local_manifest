# symlinked from local_manifest repo
# Run from root of source tree

root=`pwd`
cd $root

# Set bullshit value for filter
FILTER=bullshit

function filter_list {
	echo " Current filters:"
	echo "-----------------"
	echo " No filter <enter>"
	exit 0
}

# In order to use pstest must be in build environment
. build/envsetup.sh >/dev/null 2>&1

echo "Which filter to be used for picks [default: No filter<enter>]"
read pick_filter
case pick_filter in
	"") FILTER="" ;;
	*) echo "This is not a valid filter" && filter_list;;
esac

if [ "$FILTER" = "" ]; then

cd device/htc/m7-common
pstest 13512/2
pstest 13514/4
pstest 13518/1
pstest 13519/1
cd $root

cd frameworks/base
pstest 13505/1
pstest 13506/1
pstest 13507/1
pstest 13508/1
pstest 13509/1
cd $root

cd frameworks/native
pstest 13488/1
cd $root

cd hardware/libhardware
pstest 13515/1
pstest 13516/1
pstest 13517/1
cd $root

cd hardware/libhardware_legacy
pstest 13526/1
pstest 13527/1
pstest 13528/1
pstest 13529/1
pstest 13530/1
pstest 13531/1
pstest 13532/1
pstest 13533/1
pstest 13534/1
cd $root

cd hardware/qcom/display-caf
pstest 13501/2
cd $root

cd packages/apps/Settings
pstest 13524/1
pstest 13535/1
pstest 13536/1
cd $root

cd vendor/aokp
pstest 13537/1
cd $root

fi



