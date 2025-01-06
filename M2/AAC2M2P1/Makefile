GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) AAC2M2P1.vhd
	@$(GHDL) -e $(FLAGS) AAC2M2P1
	@$(GHDL) -r $(FLAGS) AAC2M2P1 --wave=wave.ghw --stop-time=100us