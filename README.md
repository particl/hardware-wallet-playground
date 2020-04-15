```
          _____                    _____                    _____          
         /\    \                  /\    \                  /\    \         
        /::\____\                /::\____\                /::\    \        
       /:::/    /               /:::/    /               /::::\    \       
      /:::/    /               /:::/   _/___            /::::::\    \      
     /:::/    /               /:::/   /\    \          /:::/\:::\    \     
    /:::/____/               /:::/   /::\____\        /:::/__\:::\    \    
   /::::\    \              /:::/   /:::/    /       /::::\   \:::\    \   
  /::::::\    \   _____    /:::/   /:::/   _/___    /::::::\   \:::\    \  
 /:::/\:::\    \ /\    \  /:::/___/:::/   /\    \  /:::/\:::\   \:::\____\ 
/:::/  \:::\    /::\____\|:::|   /:::/   /::\____\/:::/  \:::\   \:::|    |
\::/    \:::\  /:::/    /|:::|__/:::/   /:::/    /\::/    \:::\  /:::|____|
 \/____/ \:::\/:::/    /  \:::\/:::/   /:::/    /  \/_____/\:::\/:::/    / 
          \::::::/    /    \::::::/   /:::/    /            \::::::/    /  
           \::::/    /      \::::/___/:::/    /              \::::/    /   
           /:::/    /        \:::\__/:::/    /                \::/____/    
          /:::/    /          \::::::::/    /                  ~~          
         /:::/    /            \::::::/    /                               
        /:::/    /              \::::/    /                                
        \::/    /                \::/____/                                 
         \/____/                  ~~                                       
                                                                           
```
# Hardware Wallet Playground

The purpose of this repository is to provide an easy to setup development & test environment for hardware wallets & their integration with particl-core.
All builds are executed inside docker containers, the binaries created by these docker files are transferable and can be ran on other machines.
A docker-compose is used to setup the test environment.

## Table Of Contents
- [Installation](https://github.com/particl/hardware-wallet-playground#Installation)
- [Usage](https://github.com/particl/hardware-wallet-playground#Usage)
- [Folder Layout](https://github.com/particl/hardware-wallet-playground#Folder-Layout)
- [Docker Information](https://github.com/particl/hardware-wallet-playground#Docker-Information)

## Installation
* This playground is only available for linux.
* Install Git
* Install Docker (https://docs.docker.com/install/linux/docker-ce/debian/)
* Install Docker Compose

```
git clone https://github.com/particl/hardware-wallet-playground.git
cd hardware-wallet-playground/
make init
make test
```

## Usage
A comprehensive list of all commands that are available.

### make init
Clones all the required repositories into the subdirectories & writes it to the configuration file.
```
make init
```

### make target=[all | core | trezor | ledger] build
Builds everything (default target = all):
```
make build
```

Builds a specific target:
```
make target=core build
```

### make target=[all | trezor | ledger] test
Executes build command on core (+ specified target) first.
Boots up the containers (emulators & particl-core). Once an emulator container is up and running, it will add that emulator to particl-core and run the respective test suite (ledger / trezor).
Tests against the different emulators are ran sequentially.
Will shutdown the existing docker containers and clean up everything.

Tests everything (default target = all):
```
make test
```

Test a specific target:
```
make target=ledger test
```

### make target=[all | core | trezor | ledger] clean
Runs make clean in every source folder.

Cleans everything (default target = all):
```
make clean
```

Clean a specific target:
```
make target=ledger clean
```

### make node=[stake | ledger | trezor ] shell
Get a shell into a the container of `node`.

```
make node=stake shell
```

Only available as long as the test environment is up.

### make node=[stake | ledger | trezor ] command="getnetworkinfo" rpc
Runs `command` againt a particular `node` through particl-cli.

Retrieve the network information from node 0:
```
make node=stake command="getnetworkinfo" rpc
```

Only available as long as the test environment is up.

## Folder Structure
* `src/` contains all the source repositories cloned through git. You can directly work & edit in these.
* `bin/` contains the particl-core binary & emulator firmware.
* `scripts/` contains all the scripts that you can execute through the `make` commands.
* `docker/` contains all docker files to build & run each repo in src/ & a docker-compose file for the test environment.
* `configs/` contains the datadirectory for particl-core (which is binded to the container in the testing orchestration)

## Docker Information
All processes (compiling source codes & executing tests) runs inside docker containers that are orchestrated using docker-compose.
This simplifies the bootstrapping process for new developers and provides an additional level of security to protect your host system.

### Docker Files
* `build-legder-app-particl`: builds the ledger app firmware (when **executing** the docker container) and stores the binary under `bin/` as `particl.elf`
* `build-particl-core`: builds particl-core daemon and cli (when **executing** the docker container) and stores the binaries under `bin/` as `particld` & `particl-cli`.
* `run-particl-core`: runs particl-core daemon (particld), binaries & data directory must be mounted inside as (`particld` + `particl-cli`) & `/data` respectively.
* `run-tests`: sets up the wallet & connects the right particl-core instances with their respective hardware emulator. Afterward, run test suite against the particl-core daemons.