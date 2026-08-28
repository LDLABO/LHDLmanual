onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Yellow -format Literal -itemcolor Yellow -label TP -radix decimal /testbench/sim_tp
add wave -noupdate -color White -format Logic -itemcolor White -label CLK -radix hexadecimal /testbench/clk
add wave -noupdate -color Yellow -format Logic -itemcolor Yellow -label simres -radix hexadecimal /testbench/simres0
add wave -noupdate -color Salmon -format Logic -itemcolor Salmon -label RESET -radix hexadecimal /testbench/sim_reset0
add wave -noupdate -color Salmon -format Logic -itemcolor Salmon -label RXD -radix hexadecimal /testbench/sim_rxd0
add wave -noupdate -color Salmon -format Logic -itemcolor Salmon -label SC -radix hexadecimal /testbench/sim_sc0
add wave -noupdate -color Cyan -format Literal -itemcolor Cyan -label DATA -radix hexadecimal /testbench/sim_data
add wave -noupdate -color Cyan -format Logic -itemcolor Cyan -label PARITY -radix hexadecimal /testbench/sim_parity0
add wave -noupdate -color {Lime Green} -format Logic -itemcolor {Lime Green} -label SREQP -radix hexadecimal /testbench/sim_sreqp0
add wave -noupdate -color {Lime Green} -format Literal -itemcolor {Lime Green} -label SDATA -radix hexadecimal /testbench/sim_sdata
add wave -noupdate -color {Lime Green} -format Logic -itemcolor {Lime Green} -label CTS -radix hexadecimal /testbench/sim_cts0
add wave -noupdate -color {Lime Green} -format Literal -itemcolor {Lime Green} -label SEND -radix hexadecimal /testbench/sim_send
add wave -noupdate -color White -format Logic -itemcolor White -label rcomon -radix hexadecimal /testbench/sim_t0p0
add wave -noupdate -color White -format Logic -itemcolor White -label rcomoff -radix hexadecimal /testbench/sim_t1p0
add wave -noupdate -color White -format Literal -itemcolor White -label rshift -radix hexadecimal /testbench/sim_t2p
add wave -noupdate -color White -format Literal -itemcolor White -label bitcount -radix hexadecimal /testbench/sim_t3p
add wave -noupdate -color White -format Literal -itemcolor White -label paritycount -radix hexadecimal /testbench/sim_t4p
add wave -noupdate -color White -format Logic -itemcolor White -label scbp -radix hexadecimal /testbench/sim_t5p0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15106114 ps} 0}
configure wave -namecolwidth 107
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {15954035 ps}
