GHDL=ghdl 
FLAGS="--std=08"

all:
	@$(GHDL) -a $(FLAGS) hello.vhd
	@$(GHDL) -e $(FLAGS) hello_world
	@$(GHDL) -r $(FLAGS) hello_world --wave=wave.ghw --stop-time=1us