`timescale 1ns/1ps

module tb_counter_3bit_updown;
    reg clk;
    reg ud;
    wire Q0, Q1, Q2;
    wire [2:0] bin_out = {Q2, Q1, Q0};

    wire [7:0] SEG_DATA;
    wire [4:0] SEG_SEL;

    counter_3bit_updown counter (
        .clk(clk),
        .ud(ud),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2)
    );

    bcd2seven_seg display (
        .a(bin_out),
        .SEG_SEL(SEG_SEL),
        .SEG_DATA(SEG_DATA)
    );

    initial begin
        ud = 0;
        clk = 1;
        #1; clk = 0;
        forever #50 clk = ~clk;
    end

    initial begin
        #150; ud = 1;
        #200; ud = 0;
        #100; ud = 1;
        #100; ud = 0;
        #200; ud = 1;
        #150; $finish;
    end

    initial begin
        $monitor("Time = %t | UD = %b | Q2 Q1 Q0 = %b%b%b | SEG_DATA = %b", 
                  $time, ud, Q2, Q1, Q0, SEG_DATA);
    end

    initial begin
        $dumpfile("counter_with_sevenseg.vcd");
        $dumpvars(0, tb_counter_3bit_updown);
    end
endmodule
