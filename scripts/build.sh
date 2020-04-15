# Get directory of the script (even if symbolically linked)
script=`readlink -f "$0"`
scriptpath=`dirname "$script"`
original_dir=$(pwd)

$scriptpath/ascii.sh banner

# Core build
if [ "$target" = "all" ] ||  [ $target = "core" ]; then
echo "##################################### [ CORE BUILD ] #######################################"
    # Prepare the build environment for particl-core
    docker build \
        -t particl/build-particl-core:latest \
        -f docker/build-particl-core.Dockerfile .
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi

    # Execute compilation of particl-core
    docker run \
        --mount type=bind,source="$(pwd)"/src/particl-core,target=/particl-core \
        particl/build-particl-core
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi

# Ledger-app build
if [ "$target" = "all" ] ||  [ $target = "ledger" ]; then
echo "##################################### [ LEDGER BUILD ] ######################################"
    # Prepare build environment for ledger-app-particl
    docker build \
        -t particl/build-ledger-app-particl:latest \
        -f docker/build-ledger-app-particl.Dockerfile .
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi

    # Execute compilation of ledger-app-particl
    docker run \
        --mount type=bind,source="$(pwd)"/src/ledger-app-particl,target=/ledger-app-particl \
        particl/build-ledger-app-particl
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
echo "#############################################################################################"
fi

# Ledger-emu build
if [ "$target" = "all" ] ||  [ $target = "ledger" ]; then
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi

# Trezor build
if [ "$target" = "all" ] ||  [ $target = "trezor" ]; then
    if [ "$?" != "0" ]; then
        $scriptpath/ascii.sh error
        exit 2
    fi
fi

$scriptpath/ascii.sh success
