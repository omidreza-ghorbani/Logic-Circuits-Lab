`timescale 1ns/1ps

module tb_comparator_3bit_chain;
    reg [2:0] A, B;
    reg L_in, E_in, G_in;
    wire GT, EQ, LT;

    comparator_3bit_chain uut (
        .A    (A),
        .B    (B),
        .L_in (L_in),
        .E_in (E_in),
        .G_in (G_in),
        .GT   (GT),
        .EQ   (EQ),
        .LT   (LT)
    );

    initial begin

        L_in = 0; E_in = 1; G_in = 0;

        #5  A = 3; B = 2;
        #10 A = 7; B = 1;

        #10 A = 2; B = 5;
        #10 A = 0; B = 4;

        #10 A = 4; B = 4;
        #10 A = 7; B = 7;

        #10 L_in = 0; E_in = 0; G_in = 1;
             A    = 0; B    = 7;

        #10 L_in = 1; E_in = 0; G_in = 0;
             A    = 7; B    = 0;

        #10 $finish;
    end
endmodule
