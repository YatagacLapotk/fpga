GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) AAC2M1P1_test.vhd AAC2M1P1.vhd
	@$(GHDL) -e $(FLAGS) AAC2M1P1_test 
	@$(GHDL) -r $(FLAGS) AAC2M1P1_test --wave=wave.ghw --stop-time=1us