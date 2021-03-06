* EE213 Project task 3

* Global Include
.include "/afs/ir.stanford.edu/class/ee313/ee313_spice_header.h"

.param tcyc = 1n
.param trf  = 50p

**** Decoder
.include "/usr/class/ee313/project_part1_sol/project.decoder.ckt"
.include "/usr/class/ee313/project/stimulus.sp"

* DUT
.include "sram_full.ckt"

* Sources
Vblpc_b blpc_b gnd PULSE 0 'supply' 'tcyc/2' trf trf 'tcyc/2-trf' tcyc
Vwren0      wren0       gnd DC 0
Vwrdata0    wrdata0     gnd DC 0
Vwrdata255  wrdata255   gnd DC 0

* Initialize
***** TOP ROW 
* Top-left: 1 
.ic V(xtl.bit)    = "supply"
.ic V(xtl.bit_b) = 0

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
.tran 'trf/100' 'tcyc/2+4*tcyc'

* Measure
.meas TRAN bl63
+ TRIG v(ck) VAL='supply/2' rise=1
+ TARG v(bl63) VAL='supply-150m' fall=1

.meas TRAN bl0
+ TRIG v(ck) VAL='supply/2' rise=2
+ TARG v(bl0) VAL='supply-150m' fall=1

.end
