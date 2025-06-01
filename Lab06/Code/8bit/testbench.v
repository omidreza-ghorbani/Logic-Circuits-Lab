`timescale 1ns/1ps
module tb_comparator_8bit_chain;
    reg [7:0] A, B;
    wire GT, EQ, LT;

    comparator_8bit_chain uut (
        .A   (A),
        .B   (B),
        .GT  (GT),
        .EQ  (EQ),
        .LT  (LT)
    );

    initial begin
        #5  A = 8'd100; B = 8'd50;
        #10 A = 8'hFF; B = 8'h0F;
        #10 A = 8'd10; B = 8'd20;
        #10 A = 8'h00;B = 8'h01;
        #10 A = 8'd123;B = 8'd123;
        #10 A = 8'hA5; B = 8'hA5;
        #10 $finish;
    end
endmodule
