# symlinked from local_manifest repo
# Run from root of source tree

. build/envsetup.sh

# Initialize helper functions

. helper_functions

if [ "$1" == "--verify" ]; then
   verify=1
   [ -f $ROOT/.files_to_verify ] && rm $ROOT/.files_to_verify
fi

function pick() {
   declare -a array=("${!1}")
   if [ "$verify" == "1" ]; then
      directory=`pwd`
      echo "repo:${directory}" >> $ROOT/.files_to_verify
   fi
   for index in ${!array[@]}; do
      pstest ${array[index]}
      if [ "$verify" == "1" ]; then
         echo ${array[index]} >> $ROOT/.files_to_verify
      fi
   done
}

declare -a build=('14560')
declare -a fw_base=('14611' '14960' '14987' '14882' '14445')
declare -a romcontrol=('14584')

cd build
pick build[@]
cd -

cd device/htc/m7-common
pick m7_common[@]
cd -


cd frameworks/base
pick fw_base[@]
cd -

cd packages/apps/ROMControl
pick romcontrol[@]
cd -
