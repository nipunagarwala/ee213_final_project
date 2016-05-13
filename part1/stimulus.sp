* FILE: stimulus.sp

**********************************************************************
* External pin:
* ck: clock signal at 1GHz
* a0: address pin 0
* a255: address pin 255
* a0 and a255 alternate every other clock cycle
* Need to define cycle time tcyc, and rise
* fall time trf externally
**********************************************************************

***************************************************************
*GLOBAL INCLUDES
***************************************************************
.include "/afs/ir.stanford.edu/class/ee313/ee313_spice_header.h"

**************************************************************
*NETLISTS
**************************************************************
.include "./decoder/hspiceD/schematic/netlist/input.ckt"


*Parameters for Clock Cycle time and rise time
.PARAM tcyc = 1n
.PARAM trf = 50p


.SUBCKT inv_stimulus in out WP=24 LP=2 WN=8 LN=2
* seperate stimulus power from main supply
Vstimulus_supply vdd_stimulus gnd 'supply'
M_0 out in gnd gnd NMOS W=WN L=LN GEOMOD=0 
M_1 out in vdd_stimulus vdd_stimulus PMOS W=WP L=LP GEOMOD=0 
.ENDS

.SUBCKT inv_chain_stimulus in out
X_0 in net_1 inv_stimulus M=1
X_1 net_1 out inv_stimulus M=4
X_2 out net_3 inv_stimulus M=16
X_3 net_3 net_4 inv_stimulus M=64
.ENDS

.SUBCKT signal_gen in out
X_0 in net_2 inv_chain_stimulus
E_0 net_3 gnd net_2 gnd 1 
V_sense net_3 out 0  
V_monitor net_4 gnd 'supply'
F_0 net_4 gnd V_sense -0.5 abs=1
F_1 net_4 gnd V_sense -0.5
.ENDS

* start main CELL clock
.SUBCKT clk_gen out
Vsrc src  gnd pulse 0 'supply' 'tcyc/2' trf trf 'tcyc/2-trf' tcyc
Xgen src out signal_gen
.ENDS

* start main CELL a0
.SUBCKT a0_gen out
Vsrc src gnd pulse 0 'supply' 'tcyc/2-tcyc/8' trf trf 'tcyc-trf' '2*tcyc'
Xgen src out signal_gen
.ENDS

* start main CELL a255
.SUBCKT a255_gen out
Vsrc src gnd pulse 0 'supply' 'tcyc/2+tcyc-tcyc/8' trf trf 'tcyc-trf' '2*tcyc'
Xgen src out signal_gen
.ENDS

* Define the widths of the NMOS and PMOS of NAND and Inverters
.PARAM pw_inv1 = 82.3049
.PARAM nw_inv1 = 41.1524
.PARAM pw_nand1 = 26.087
.PARAM nw_nand1 = 23.913
.PARAM pw_inv2 = 179.84
.PARAM nw_inv2 = 84.92 
.PARAM pw_inv3 = 567.4
.PARAM nw_inv3 = 283.7
.PARAM pw_inv4 = 1790.2
.PARAM nw_inv4 = 895.08
.PARAM pw_nand2 = 57.0015
.PARAM nw_nand2 = 40.376
.PARAM pw_nand3 = 299.4848
.PARAM nw_nand3 = 212.1351
.PARAM pw_inv5 = 912.9731
.PARAM nw_inv5 = 456.4866

* generate clock and address signal
Xclk_gen clk clk_gen
Xa0_gen add0 a0_gen
Xa255_gen add255 a255_gen

*Measure the signals
.tran 0.3p 10n

.meas tran wl0R                trig v(clk)  val='supply/2' rise=1
+                              targ v(wl0_wire) val='supply/2' rise=1
.meas tran wl0F                trig v(clk)  val='supply/2' fall=1
+                              targ v(wl0_wire) val='supply/2' fall=1
.meas tran pdec24R             trig v(clk)  val='supply/2' rise=1
+                              targ v(inv1_wire) val='supply/2' rise=1
.meas tran pdec24F             trig v(clk)  val='supply/2' fall=1
+                              targ v(inv1_wire) val='supply/2' fall=1
.meas tran pdec416R            trig v(inv1_wire)  val='supply/2' rise=1
+                              targ v(predec_wire) val='supply/2' rise=1
.meas tran pdec416F            trig v(inv1_wire)  val='supply/2' fall=1
+                              targ v(predec_wire) val='supply/2' fall=1
.meas tran decR                trig v(predec_wire)  val='supply/2' rise=1
+                              targ v(wl0_wire) val='supply/2' rise=1
.meas tran decF                trig v(predec_wire)  val='supply/2' fall=1
+                              targ v(wl0_wire) val='supply/2' fall=1

.meas tran wl0RiseTime            param='wl0R'
.meas tran wl0FallTime             param='wl0F'
.meas tran pdec24RiseTime             param='pdec24R'
.meas tran pdec24FallTime             param='pdec24F'
.meas tran pdec416RiseTime             param='pdec416R'
.meas tran pdec416FallTime             param='pdec416F'


.probe

.end
