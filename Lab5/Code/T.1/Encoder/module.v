`timescale 1ns / 1ps

module Encoder_4X2 (x0,x1,x2,x3,a0,a1);
input x0,x1,x2,x3;
output a0,a1;
wire x3_not,x3nx1;
not g1(x3_not,x3);
and g2(x3nx1,x3_not,x1);
or g3(a0,x3nx1,x3);
or g4(a1,x2,x3);
endmodule