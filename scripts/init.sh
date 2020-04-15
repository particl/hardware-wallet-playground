## SETUP SYMLINKS
ln -s "$(pwd)/src/ledger-app-particl/bin" "$(pwd)/bins/ledger-app-particl"
ln -s "$(pwd)/src/particl-core/src/particld" "$(pwd)/bins/particld"
ln -s "$(pwd)/src/particl-core/src/particl-cli" "$(pwd)/bins/particl-cli"
ln -s "$(pwd)/src/particl-core/test/functional/test_framework" "$(pwd)/tests/functional/test_framework"
ln -s "$(pwd)/src/speculos/Dockerfile" "$(pwd)/docker/run-ledger-emulator.Dockerfile"

## SETUP SRCs
cd src
# particl-core
git clone https://github.com/particl/particl-core.git
# ledger stuff
git clone https://github.com/LedgerHQ/ledger-app-particl.git
git clone https://github.com/LedgerHQ/speculos.git

# trezor stuff
git clone https://github.com/trezor/trezor-firmware.git

