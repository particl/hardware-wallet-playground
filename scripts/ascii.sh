# Get directory of the script (even if symbolically linked)
script=`readlink -f "$0"`
scriptpath=`dirname "$script"`

if [ "$1" = "banner" ]; then
    # Get latest commit messages or check if uncommited changes are present.
    core_msg=$(cd $core_src && ((git diff-index --quiet HEAD -- && git log -1 --pretty="(%h) %B" || echo "uncommited changes")) | cut -c1-50)
    ledger_app_msg=$(cd $ledger_app_src && ((git diff-index --quiet HEAD -- && git log -1 --pretty="(%h) %B" || echo "uncommited changes")) | cut -c1-50)
    ledger_emu_msg=$(cd $ledger_emulator_src && ((git diff-index --quiet HEAD -- && git log -1 --pretty="(%h) %B" || echo "uncommited changes")) | cut -c1-50)
    trezor_msg=$(cd $trezor_src && ((git diff-index --quiet HEAD -- && git log -1 --pretty="(%h) %B" || echo "uncommited changes")) | cut -c1-50)
    echo "#############################################################################################"
    echo "     (  )   (   )  )                      "
    echo "      ) (   )  (  (                       "
    echo "      ( )  (    ) )                       "
    echo "      _____________           TARGET:     $target"
    echo "     <_____________> ___      CORE:       $core_msg"
    echo "     |             |/ _ \     LEDGER_APP: $ledger_app_msg"
    echo "     |    BUILD      | | |    LEDGER_EMU: $ledger_emu_msg"
    echo "     |               |_| |    TREZOR:     $trezor_msg"
    echo "  ___|             |\___/                 "
    echo " /    \___________/    \                  "
    echo " \_____________________/     Art by Elissa Potier "
    echo "#############################################################################################"
fi

if [ "$1" = "success" ]; then
    echo "#############################################################################################"
    cat $scriptpath/art-success.txt
    echo "#############################################################################################"
fi

if [ "$1" = "error" ]; then
    echo "#############################################################################################"
    cat $scriptpath/art-error.txt
    echo "#############################################################################################"
fi