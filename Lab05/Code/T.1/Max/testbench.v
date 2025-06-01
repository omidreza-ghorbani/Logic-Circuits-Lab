`timescale 1ns / 1ps

module tb_Mux4X1;
  reg w0, w1, w2, w3;
  reg s0, s1;
  wire y;
  wire [1:0] s;
  
  assign s = {s1, s0};
  
  Mux4X1 uut (.w({w3, w2, w1, w0}), .s(s), .y(y));
  
  initial begin
    $monitor("Time = %0t | w = %b | s = %b | y = %b", $time, {w3, w2, w1, w0}, s, y);
    
    w0 = 1; w1 = 0; w2 = 0; w3 = 0;
    s0 = 0; s1 = 0; #10;
    s0 = 1; s1 = 0; #10;
    s0 = 0; s1 = 1; #10;
    s0 = 1; s1 = 1; #10;
    
    w0 = 0; w1 = 1; w2 =0; w3 = 0;
    s0 = 0; s1 = 0; #10;
    s0 = 1; s1 = 0; #10;
    s0 = 0; s1 = 1; #10;
    s0 = 1; s1 = 1; #10;
    
    w0 =0; w1 =0; w2 = 1; w3 = 0;
    s0 = 0; s1 = 0; #10;
    s0 = 1; s1 = 0; #10;
    s0 = 0; s1 = 1; #10;
    s0 = 1; s1 = 1; #10;
    
	 w0 = 0; w1 =0; w2 = 0; w3 = 1;
    s0 = 0; s1 = 0; #10;
    s0 = 1; s1 = 0; #10;
    s0 = 0; s1 = 1; #10;
    s0 = 1; s1 = 1; #10;
    $finish;
  end
endmodule
