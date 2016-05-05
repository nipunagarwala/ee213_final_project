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