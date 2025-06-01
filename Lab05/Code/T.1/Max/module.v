`timescale 1ns / 1ps

module Mux4X1(w, s, y);
  input  [3:0] w;   
  input  [1:0] s;  
  output  y; 

  wire [1:0] s_not; 
  wire [3:0] ands;   

  not n1(s_not[0], s[0]);
  not n2(s_not[1], s[1]);

  and a1(ands[0],w[0],s_not[0],s_not[1]);
  and a2(ands[1],w[1],s_not[0],s[1]);
  and a3(ands[2],w[2],s[0],s_not[1]);
  and a4(ands[3],w[3],s[0],s[1]);

  or o1(y, ands[0], ands[1], ands[2], ands[3]);
endmodule
