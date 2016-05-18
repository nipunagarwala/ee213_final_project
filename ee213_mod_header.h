******************* default header for EE313 ******************

.param supply=1.0       	$$ Our nominal power supply is 1.0 volts
.option scale=0.022u      	$$ EE-313 uses Lambda=0.022 microns
.option accurate post
.option dcic=0
.global vdd_dec vdd! vdd gnd
.option parhier=local
.option list
.op

.protect
.lib '/usr/class/ee313/lib/opConditions.lib' TTTT
.unprotect

V_supply vdd gnd dc=Supply
V_supply1 vdd! gnd dc=Supply
V_supply2 vdd_dec gnd dc=Supply
vgnd gnd 0 0
*********************** end header ******************************
