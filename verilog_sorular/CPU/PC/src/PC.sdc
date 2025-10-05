//Copyright (C)2014-2025 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.11.01 Education 
//Created Time: 2025-07-31 18:54:13
create_clock -name clk -period 400 -waveform {0 200} [get_ports {clk}] -add
