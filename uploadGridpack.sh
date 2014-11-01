#! /bin/bash


function preparepath() {
  local PROCESS=${rootdir}/
  local lastv=-1
  local newv=-1
  if [ -d $PROCESS ]; then
    local listversions=`ls $PROCESS | grep "^v[0-9]\+"`
    if [[ ${listversions} != "" ]]; then
      lastv=`echo ${listversions}|tr " " "\n" | sed -e "s#v\([0-9]\+\)#\1#g" | sort -n | tail -n1`
    fi
  fi  
  if [[ ${lastv} == -1 ]]; then 
    newv=1
  else 
    newv=$(($lastv+1))
  fi

  echo ${PROCESS}/v${newv}

}

# parse command line arguments and options
NAME=$(basename $0)
OPTS=$(getopt -n "$NAME" -o "hnp:e:" -l "help,dryrun,process:,energy:,arch:,mgversion:" -- "$@")

# check for invalid options
if [ $? != 0 ]; then 
  exit 1
fi

# reload the parsed options into the environment
eval set -- "$OPTS"

# parse options
ENERGY=""
PROCESS=""
DRYRUN=""
while true; do
  case "$1" in 
    "-p" | "--process" )
      PROCESS="$2"
      shift 2
      echo PROCESS=$PROCESS
      ;;
    "-e" | "--energy" )
      ENERGY="$2"
      shift 2
      echo ENERGY=$ENERGY
      ;;
    "-n" | "--dryrun" )
      DRYRUN="1"
      shift
      echo dryrun
      ;;
    "-e" | "--arch" )
      ARCH="$2"
      shift 2
      echo ARCH=$ARCH
      ;;
    "-e" | "--mgversion" )
      MGVERSION="$2"
      shift 2
      echo MGVERSION=$MGVERSION
      ;;
    "-h" | "--help" )
      echo "usage: ./${NAME} --energy [8TeV,13TeV] --process <process name> --arch <architecture> --mgversion <MadGraph version> <process name>_gridpack.tar.gz"
      exit 0
      ;;
    "--" )
      # inserted by getopt to signal the end of options
      shift
      break
      ;;
  esac
done

rootdir=/afs/cern.ch/cms/generators/www/${ARCH}/${ENERGY}/madgraph/${MGVERSION}/${PROCESS}/

if [ ! "$ENERGY" ]; then
  echo "$NAME: error: the --energy option is required"
  exit 1
fi

if [ ! "$MGVERSION" ]; then
  echo "$NAME: error: the --mgversion option is required"
  exit 1
fi

if [ ! "$ARCH" ]; then
  echo "$NAME: error: the --arch option is required"
  exit 1
fi

if [ ! "$PROCESS" ]; then
  echo "$NAME: error: the --process option is required"
  exit 1
fi

if [[ "$(echo $@| wc -w)" == 0 ]]; then
  echo "$NAME: error: no files provided for upload"
  exit 1
fi  

for file in "$@"; do
  if [ ! -f ${file} ]; then
    echo "$NAME: error: file $file does not exist"
    exit 1
  fi
  if [[ "$(basename $file| sed -e 's#\.[a-z\.]\+##g')" != "${PROCESS}_gridpack" ]]; then
    echo "$NAME: error: file $file had wrong basename"
    exit 1;
  fi  
done


path="$(preparepath)"
echo "new path ${path}"

if [ ! "$DRYRUN" ]; then
  mkdir -p ${path} 
  for file in "$@"; do
    cp ${file} ${path}  
  done
fi  
exit 0

