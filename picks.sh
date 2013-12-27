# symlinked from local_manifest repo
# Run from root of source tree

. build/envsetup.sh

# Initialize helper functions

. helper_functions

if [ "$1" == "--verify" ]; then
   verify=1
fi

function pick() {
   declare -a array=("${!1}")
   if [ "$verify" == "1" ]; then
      directory=`pwd`
      [ -e $ROOT/.files_to_verify ] || rm $ROOT/.files_to_verify
      echo $directory >> $ROOT/.files_to_verify
   fi
   for index in ${!array[@]}; do
      pstest ${array[index]}
      if [ "$verify" == "1" ]; then
         echo ${array[index]} >> $ROOT/.files_to_verify
      fi
   done
}

declare -a m7tmo=('14456')
declare -a m7_common=('14345' '14459' '14448' '14460')
declare -a htc_msm8960=('14346')
declare -a fw_base=('14068' '14221' '14445' '14446' '14224')
declare -a romcontrol=('14150' '14447')

cd device/htc/m7tmo
pick m7tmo[@]
cd -

cd device/htc/m7-common
pick m7_common[@]
cd -

cd device/htc/msm8960-common
pick htc_msm8960[@]
cd -

cd frameworks/base
pick fw_base[@]
cd -

cd packages/apps/ROMControl
pick romcontrol[@]
cd -
