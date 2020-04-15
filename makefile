ifeq ($(target),)
target := "all"
endif

ifeq ($(core_src),)
core_src = "src/particl-core"
endif

ifeq ($(ledger_app_src),)
ledger_app_src = "src/ledger-app-particl"
endif

ifeq ($(ledger_emulator_src),)
ledger_emulator_src = "src/speculos"
endif

ifeq ($(trezor_src),)
trezor_src = "src/trezor-firmware"
endif

ifeq ($(node),)
node = 0
endif

ifeq ($(command),)
command = "help"
endif

# Get only the variables with plain names
interesting_variables = target model node command core_src ledger_app_src ledger_emulator_src trezor_src
settings = $(foreach v,$(interesting_variables),$(v)=$($(v)))

init : 
	$(settings) ./scripts/init.sh
build : 
	$(settings) ./scripts/build.sh
test : 
	# $(settings) ./scripts/build.sh
	$(settings) ./scripts/test.sh
clean :
	$(settings) ./scripts/clean.sh
rpc :
	$(settings) ./scripts/rpc.sh
shell :
	$(settings) ./scripts/shell.sh
vnc :
	$(settings) ./scripts/vnc.sh
echo :
	echo '$(settings)'