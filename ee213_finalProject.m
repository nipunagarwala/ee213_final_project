%EE213 Final Project
%Part 1

% Decoder Sizing

num_cells_width = 256;
num_cells_height = 256;
lambda = 0.022;
width = 54;
height = 16;
L = 2*lambda;
EcL = 0.5;
Vth = 0.3;
Cg = 1.3*10^(-15);
Cj = 1.2*10^(-15);
Cw = 0.2*10^(-15);
Cin = 100*Cg*lambda;
Vdd = 1;
m3_width = 6;
m2_width = 4;
m1_width = 4;
stages = 8;
b1 = 2;
b2 = 4;
b3 = 16;

% Calculating Logical Effort
nand2_wid = ((Vdd - Vth) + 2*EcL)/((Vdd - Vth) + EcL);
LE_nand2 = (nand2_wid + 2)/3
nand3_wid = ((Vdd - Vth) + 3*EcL)/((Vdd - Vth) + EcL);
LE_nand3 = (nand3_wid + 2)/3

% Calculating total LE
G = LE_nand3*LE_nand2^2

% Calculating total Load
Cout = (2*Cg*m2_width + 54*Cw)*num_cells_width*lambda

% Fanout
H = Cout/Cin;

% Branching
B = b1*b2*b3;

% Stage Effort
F = G*B*H
f = (G*B*H)^(1/8)
cal_stages = log(F)/log(4);

Cout
c_inv5 = Cout/f
c_nand3 = c_inv5*LE_nand2/f
c_inv4 = c_nand3*b3/f
c_inv3 = c_inv4/f
c_inv2 = c_inv3/f
c_nand2 = c_inv2*LE_nand2/f
c_inv1 = c_nand2*b2/f
c_nand1 = c_inv1*LE_nand3/f

% Sideload
load_pdec = height*num_cells_height*lambda*Cw

% Resizing all the Gates based on side load
pdec_out = (load_pdec + c_nand3)*b3;
B_pdec = b1*b2;
H_pdec = pdec_out/Cin;
G_pdec = LE_nand3*LE_nand2;
F_pdec = G*B*H
n_pdec = 6;
f_pdec = (G*B*H)^(1/n_pdec);
pdec_stages = log(F_pdec)/log(4)

% Finding the resized Gates before side load
pdec_inv4 = pdec_out*b3/f_pdec
pdec_inv3 = pdec_inv4/f_pdec
pdec_inv2 = pdec_inv3/f_pdec
pdec_nand2 = pdec_inv2*LE_nand2/f_pdec
pdec_inv1 = pdec_nand2*b2/f_pdec
pdec_nand1 = pdec_inv1*LE_nand3/f_pdec

% Finding the re-sized gates after the side load
dec_in = pdec_inv4
G_dec = LE_nand3;
B_dec = b3;
F_dec = G*B*Cout/dec_in
n_dec = 2;
f_dec = (F_dec)^(1/2)
dec_stages = log(F_dec)/log(4)

dec_inv5 = Cout/f_dec
dec_nand3 = dec_inv5*LE_nand2/f_dec
dec_inv4 = dec_nand3*b3/f_dec

