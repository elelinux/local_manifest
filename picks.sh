# symlinked from local_manifest repo
# Run from root of source tree

. build/envsetup.sh

# Initialize helper functions

. helper_functions

function cr() {
   cd - > /dev/null
}

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

declare -a bionic=('15646')
declare -a build=('14560' '15458')
declare -a fw_base=('14470' '15432' '15374' '15434' '15450')
declare -a msm8960_kernel=('15669')
declare -a romcontrol=('14555' '15435')
declare -a telephony=('15462')
declare -a white=('15618')
declare -a vold=('15440' '15441')

cd bionic
pick bionic[@]
cr

cd build
pick build[@]
cr

cd frameworks/base
pick fw_base[@]
cr

cd kernel/htc/msm8960
pick m7_kernel[@]
cr

cd packages/apps/ROMControl
pick romcontrol[@]
cr

cd packages/services/Telephony
pick telephony[@]
cr

cd packages/themes/KitKatWhite
pick white[@]
cr

cd system/vold
pick vold[@]
cr
