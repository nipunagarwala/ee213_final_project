* EE213 Project task 3

* Global Include
*.include "/afs/ir.stanford.edu/class/ee313/ee313_spice_header.h"
.include "./../../ee213_mod_header.h"
.param tcyc = 1n
.param trf  = 50p

**** Decoder
.include "/usr/class/ee313/project_part1_sol/project.decoder.ckt"
.include "/usr/class/ee313/project/stimulus.sp"

* DUT
.include "sram_full.ckt"

* Sources
.SUBCKT blpc_gen out
Vsrc src  gnd pulse 0 'supply' 'tcyc/2' trf trf 'tcyc/2-trf' tcyc
Xgen src out signal_gen
.ENDS

*Vblpc_b blpc_b gnd PULSE 0 'supply' 'tcyc/2' trf trf 'tcyc/2-trf' tcyc
Vwren0      wren0       gnd DC 0
Vwrdata0    wrdata0     gnd DC 0
Vwrdata255  wrdata255   gnd DC 0

Vb0 bl0 gnd DC 'supply'
Vbl_b bl_b0 gnd DC 'supply'

* Initialize
***** TOP ROW 
* Top-left: 1 
.ic V(xtl.bit)    = "supply"
.ic V(xtl.bit_b) = "supply"

* Top-middle: 1?
.ic V(xtm.bit)    = "supply"
.ic V(xtm.bit_b) = 0

* Top-right: 0 
.ic V(xtr.bit)    = 0
.ic V(xtr.bit_b) = "supply"

****** MIDDLE ROW
* Middle-left: 1?
.ic V(xml.bit)    = "supply"
.ic V(xml.bit_b) = 0

* Middle-middle: 1?
.ic V(xmm.bit)    = "supply"
.ic V(xmm.bit_b) = 0

* Middle-right: 1?
.ic V(xmr.bit)    = "supply"
.ic V(xmr.bit_b) = 0

******* BOTTOM ROW
* Bottom-left: 0   
.ic V(xbl.bit)    = 0
.ic V(xbl.bit_b) = "supply"

* Bottom-middle: 1?
.ic V(xbm.bit)    = "supply"
.ic V(xbm.bit_b) = 0

* Bottom-right: 1
.ic V(xbr.bit)    = "supply"
.ic V(xbr.bit_b) = 0

* Analysis
Xblpc_gen blpc_b blpc_gen
.tran 'trf/100' 'tcyc/2+4*tcyc'
*.DC xv 0 1 0.1

* Measure
*.meas TRAN bl63
*+ TRIG v(ck) VAL='supply/2' rise=1
*+ TARG v(bl63) VAL='supply-150m' fall=1

*.meas TRAN bl0
*+ TRIG v(ck) VAL='supply/2' rise=2
*+ TARG v(bl0) VAL='supply-150m' fall=1

*.measure avg_cur AVG i(v_supply2) FROM=1n TO=2n
*.meas TRAN blpc_power
*+ AVG i(Xblpc_gen.Xgen.V_monitor) FROM='2*tcyc' TO='3*tcyc'

.measure idsat MAX i(xtl.m4) FROM=1n TO=2n

.end
