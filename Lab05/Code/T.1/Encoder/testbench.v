`timescale 1ns / 1ps

module tb_Encoder_4X2;

    reg x0, x1, x2, x3;
    wire a0, a1;
    
    Encoder_4X2 uut (
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .a0(a0),
        .a1(a1)
    );
    
    initial begin
        // ثبت اطلاعات در فایل waveform (اختیاری)
        $dumpfile("tb_Encoder_4X2.vcd");
        $dumpvars(0, tb_Encoder_4X2);
        
        // نمایش وضعیت سیگنال‌ها در کنسول
        $monitor("Time = %0t | x3=%b x2=%b x1=%b x0=%b || a1=%b a0=%b", $time, x3, x2, x1, x0, a1, a0);
        
        x0 = 0; x1 = 0; x2 = 0; x3 = 0; #10;
        x0 = 1; x1 = 0; x2 = 0; x3 = 0; #10;
        x0 = 0; x1 = 1; x2 = 0; x3 = 0; #10;
        x0 = 1; x1 = 1; x2 = 0; x3 = 0; #10;
        x0 = 0; x1 = 0; x2 = 1; x3 = 0; #10;
        x0 = 1; x1 = 0; x2 = 1; x3 = 0; #10;
        x0 = 0; x1 = 1; x2 = 1; x3 = 0; #10;
        x0 = 1; x1 = 1; x2 = 1; x3 = 0; #10;
        
        x0 = 0; x1 = 0; x2 = 0; x3 = 1; #10;
        x0 = 1; x1 = 0; x2 = 0; x3 = 1; #10;
        x0 = 0; x1 = 1; x2 = 0; x3 = 1; #10;
        x0 = 1; x1 = 1; x2 = 0; x3 = 1; #10;
        x0 = 0; x1 = 0; x2 = 1; x3 = 1; #10;
        x0 = 1; x1 = 0; x2 = 1; x3 = 1; #10;
        x0 = 0; x1 = 1; x2 = 1; x3 = 1; #10;
        x0 = 1; x1 = 1; x2 = 1; x3 = 1; #10;
        
        $finish;
    end

endmodule
