******************* default header for EE313 ******************

.param supply=1.0       	$$ Our nominal power supply is 1.0 volts
.option scale=0.022u      	$$ EE-313 uses Lambda=0.022 microns
.option accurate post
.option dcic=0
.global vdd! vdd gnd
.option parhier=local
.option list
.op

.protect
.lib '/usr/class/ee313/lib/opConditions.lib' TTTT
.unprotect

V_supply vdd gnd dc=1
V_supply1 vdd! gnd dc=1
V_supply2 vdd_pre1 gnd dc=1
V_supply3 vdd_pre2 gnd dc=1
V_supply4 vdd_dec gnd dc=1

vgnd gnd 0 0
*********************** end header ******************************
