module ALU_tb;

    reg [1:0] sel;
    reg [1:0] A, B;
    wire [3:0] Y;

    ALU uut (
        .sel(sel),
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        A =2'b10;
        B =2'b01;

        sel = 2'b00;#10; 
        sel = 2'b01;#10; 
        sel = 2'b10;#10; 
        sel = 2'b11;#10; 
        $finish;
    end

endmodule
