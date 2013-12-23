# symlinked from local_manifest repo
# Run from root of source tree

# Initialize helper functions
. helper_functions

function pick() {
   local array=$1
   for i in ${array[@]} do
       pstest $i
   done
}

declare -a repos=("device_htc_m7-common" "frameworks_base")
declare -a repo_arrays=('m7-common' 'fw_base' 'settings')
declare -a m7-common=('14130' '14091')
declare -a fw_base=('14068' '14069')

for index in ${!repos[*]}; do
    dir=$( echo ${repos[index]} | sed 's/_/\//g' )
    cd $dir
    array=${repo_arrays[$index]}
    pick $array
    cd $ROOT
done
