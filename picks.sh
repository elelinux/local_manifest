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
declare -a m7_common=('14091' '14345')
declare -a htc_msm8960=('14346')
declare -a fw_base=('14068' '14221')

cd device/htc/m7-common
pick m7_common[@]
cd -

cd device/htc/msm8960-common
pick htc_msm8960[@]
cd -

cd frameworks/base
pick fw_base[@]
cd -

