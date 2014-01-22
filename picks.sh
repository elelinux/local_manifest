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

declare -a build=('14560' '15458')
declare -a fw_base=('14470' '15062' '15432' '15374' '15434' '15450' '15459')
declare -a camera2=('15379')
declare -a gallery2=('15378')
declare -a romcontrol=('14555' '15435' '15330')
declare -a telephony=('14562')

cd build
pick build[@]
cr

cd frameworks/base
pick fw_base[@]
cr

cd packages/apps/Camera2
pick camera2[@]
cr

cd packages/apps/Gallery2
pick gallery2[@]
cr

cd packages/apps/ROMControl
pick romcontrol[@]
cr

cd packages/services/Telephony
pick telephony[@]
cr
