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
declare -a fw_base=('13696' '13697' '13703' '13699' '13704' '15241' '15212' '14470' '15187' '15062' '15211')
declare -a romcontrol=('15236' '15175' '15213' '14555' '15214' '15188')
declare -a settings=('15168')

cd build
# add new pstest
pstest 15223
cd -

. build/envsetup.sh

cd 
pick build[@]
cd -

cd frameworks/base
pick fw_base[@]
cd -

cd packages/apps/ROMControl
pick romcontrol[@]
cd -

cd packages/apps/Settings
pick settings[@]
cd -
