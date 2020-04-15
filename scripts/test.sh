export COMPOSE_PROJECT_NAME="hwp"

# Get directory of the script (even if symbolically linked)
script=`readlink -f "$0"`
scriptpath=`dirname "$script"`
rootpath=`dirname "$scriptpath"`

# Prepare the execution environment for particl-core
if [ "$target" = "all" ] ||  [ $target = "core" ]; then
echo "##################################### [ CORE RUN ] #######################################"
    docker build \
        -t particl/run-particl-core:latest \
        -f docker/run-particl-core.Dockerfile .
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi

# Prepare the execution environment for the ledger emulator
if [ "$target" = "all" ] ||  [ $target = "core" ]; then
echo "################################ [ LEDGER EMULATOR RUN ] ##################################"
    docker build \
        -t particl/run-ledger-emulator:latest \
        -f docker/run-ledger-emulator.Dockerfile $rootpath/src/speculos
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi

echo "##################################### [   CLEARING   ] #######################################"
rm -rf configs/core-datadir-*/regtest
mkdir configs/core-datadir-stake/regtest
mkdir configs/core-datadir-ledger-nanos/regtest
mkdir configs/core-datadir-trezor/regtest

echo "##################################### [   TESTING   ] #######################################"

# Boot up the containers with orchestration (docker-compose)
if [ "$target" = "all" ]]; then
    docker-compose -f docker/test-compose.yaml up
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi