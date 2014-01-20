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

declare -a bionic=('15386' '15387' '15388' '15389' '15390' '15391' '15392' '15393' '15394' '15395' '15396')
declare -a build=('14560')
declare -a dalvik=('15397')
declare -a m7_common=('15398' '15399' '15400')
declare -a fw_base=('15062' '15403' '15404' '15405' '15406' '15407' '15408' '15409' '15410' '15411' '15412' '15413')
declare -a fw_rs=('15401')
declare -a htc=('15402')
# declare -a romcontrol=('')

cd bionic
pick bionic[@]
cd -

cd build
pick build[@]
cd -

cd dalvik
pick dalvik[@]
cd -

cd device/htc/m7-common
pick m7_common[@]
cd -

cd frameworks/base
pick fw_base[@]
cd -

cd frameworks/rs
pick fw_rs[@]
cd -

cd vendor/htc
pick htc[@]
cd -

# cd packages/apps/ROMControl
# pick romcontrol[@]
# cd -
