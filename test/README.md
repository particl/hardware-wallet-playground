# Testing

## Table Of Contents
- [Usage](https://github.com/particl/hardware-wallet-playground/tree/master/test#Usage)
- [File Layout](https://github.com/particl/hardware-wallet-playground/tree/master/test#Folder-Layout)

## Usage 
Everything is executed inside the test container which executes RPC commands against the particl-core daemon containers.

### test_runner.py [ all | core | trezor ]
Sets up the containers (using `setup.py`) & start executing the test suites.
```
python3 test_runner.py all
```

### setup.py [ all | stake | core | trezor ]
Setup all the wallets, connect to the emulators & verify that they are responsive.
```
python3 setup.py all
```

## File Layout
* `setup.py` setup procedure for all three type of nodes (stake, ledger & trezor node).
* `test_runner.py` based on the type of node, selects & executes the appropriate tests from `functional/`.
* `functional/ ` directory that contains all the functional tests.
    * `test_framework/` symlink to `src/particl-core/test/functional/test_framework` which contains all the utilities to interact with the particl-core daemons.
    * `hardware_*.py/` shared tests that apply to all hardware wallets.
    * `ledger_*.py/` tests that apply only to ledger hardware wallets.
    * `trezor_*.py/` tests that apply only to the trezor hardware wallet.
