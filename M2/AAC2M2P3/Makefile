GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) AAC2M2P3.vhd
	@$(GHDL) -e $(FLAGS) FSM
	@$(GHDL) -r $(FLAGS) FSM --wave=wave.ghw --stop-time=100us