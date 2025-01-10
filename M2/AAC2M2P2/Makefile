GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) AAC2M2P2.vhd
	@$(GHDL) -e $(FLAGS) RAM128_32
	@$(GHDL) -r $(FLAGS) RAM128_32 --wave=wave.ghw --stop-time=100us