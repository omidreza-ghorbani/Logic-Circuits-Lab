`timescale 1ns / 1ps

module decoder4to2_tb;

    reg a, b, enable;
    wire o0, o1, o2, o3;

    decoder4to2 uut (
        .a(a),
        .b(b),
        .enable(enable),
        .o0(o0),
        .o1(o1),
        .o2(o2),
        .o3(o3)
    );

    initial begin
        $monitor("Time = %t | a = %b, b = %b, enable = %b || o0 = %b, o1 = %b, o2 = %b, o3 = %b", 
                 $time, a, b, enable, o0, o1, o2, o3);

        enable = 0;
        a = 0;
        b = 0;
        #10;

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        enable = 1;
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
