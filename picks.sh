# symlinked from local_manifest repo
# Run from root of source tree

# Initialize helper functions
. helper_functions
. build/envsetup.sh

function pick() {
   declare -a array=("${!1}")
   for index in ${!array[@]}; do
       pstest ${array[index]}
   done
}

#declare -a repos=("device_htc_m7-common" "frameworks_base")
#declare -a repo_arrays=('m7_common' 'fw_base' 'settings')
declare -a m7_common=('14091')
declare -a fw_base=('14068' '14069')

cd device/htc/m7-common
pick m7_common[@]
cd -

cd frameworks/base
pick fw_base[@]
cd -

