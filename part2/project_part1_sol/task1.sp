* FILE: task1.sp
* Decoder Design

******************* default header for EE313 ******************
*.include '/usr/class/ee313/ee313_spice_header.h'
*********************** end header ******************************
.param tcyc = 1ns
.param trf = 50ps

.include './project.dec_stage.ckt'
.include 'stimulus.sp'
.include '../../ee213_mod_header.h'
* wordline loading
Cwl0 wl0 gnd 115.97fF
Cwl255 wl255 gnd 115.97fF

*Different Voltage suppliers
*V_supply2 vdd_dec gnd dc=Supply

.tran 'trf/10' '4.5*tcyc'

.meas TRAN tdr
+ TRIG v(ck)  VAL='supply/2' rise=1
+ TARG v(wl0) VAL='supply/2' rise=1

.meas TRAN tdf
+ TRIG v(ck)  VAL='supply/2' fall=1
+ TARG v(wl0) VAL='supply/2' fall=1

.measure avg_cur AVG i(v_supply2) FROM=1n TO=2n
.meas TRAN ck_power
+ AVG i(Xclk_gen.Xgen.V_monitor) FROM='2*tcyc' TO='3*tcyc'

.END
***********************************************************************
* End of Deck
***********************************************************************

  
