GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) AAC2M2P1_test.vhd
	@$(GHDL) -e $(FLAGS) AAC2M1P1_tb 
	@$(GHDL) -r $(FLAGS) AAC2M1P1_tb --wave=wave.ghw --stop-time=1us