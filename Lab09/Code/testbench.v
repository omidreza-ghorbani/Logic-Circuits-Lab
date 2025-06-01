module jk_ff (
    input clk,
    input j, k,
    output reg q
);
    initial begin
        q = 0;
    end
    always @(negedge clk) begin
        case ({j, k})
            2'b00: q <= q;     
            2'b01: q <= 0;     
            2'b10: q <= 1;     
            2'b11: q <= ~q;    
        endcase
    end
endmodule

module counter_3bit_updown (
    input clk,
    input ud,         
    output Q0, Q1, Q2
);
    wire Q0_internal, Q1_internal, Q2_internal;
    wire Q0_bar, Q1_bar, Q2_bar;
    wire j0 = 1'b1;
    wire k0 = 1'b1;
    jk_ff ff0 (.clk(clk), .j(j0), .k(k0), .q(Q0_internal));
    assign Q0_bar = ~Q0_internal;

    wire j1 = (ud & Q0_internal) | (~ud & Q0_bar);
    wire k1 = j1;
    jk_ff ff1 (.clk(clk), .j(j1), .k(k1), .q(Q1_internal));
    assign Q1_bar = ~Q1_internal;

    wire s = (ud & Q0_internal & Q1_internal);
    wire r = (~ud & Q0_bar & Q1_bar);
    wire j2 = s | r;
    wire k2 = j2;
    jk_ff ff2 (.clk(clk), .j(j2), .k(k2), .q(Q2_internal));
    assign Q2_bar = ~Q2_internal;

    assign Q0 = Q0_bar,
           Q1 = Q1_bar,
           Q2 = Q2_bar;
endmodule

module freqDivider (
    input clk_in,
    output reg clk_out
);
    reg[25:0] counter = 0;
    always @(posedge clk_in)
        begin
            if (counter == 10000000 - 1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end
            else begin
                counter <= counter + 1;
            end
        end
endmodule

module bcd2seven_seg (
    input [2:0] a,
    output wire [4:0] SEG_SEL,
    output reg [7:0] SEG_DATA
);
    always @(a) begin
        case (a)
            3'b000: SEG_DATA = 8'b01111111; 
            3'b001: SEG_DATA = 8'b00000110; 
            3'b010: SEG_DATA = 8'b01011011; 
            3'b011: SEG_DATA = 8'b01001111; 
            3'b100: SEG_DATA = 8'b01100110; 
            3'b101: SEG_DATA = 8'b01101101; 
            3'b110: SEG_DATA = 8'b01111101; 
            3'b111: SEG_DATA = 8'b00000111; 
            default: SEG_DATA = 8'b00000000;
        endcase
    end

    assign SEG_SEL = 5'b00001; 
endmodule

module top (
    input clk,        
    input ud,         
    output [7:0] SEG_DATA,
    output [4:0] SEG_SEL
);
    wire clk_slow;
    wire Q0, Q1, Q2;

    freqDivider fd (
        .clk_in(clk),
        .clk_out(clk_slow)
    );

    counter_3bit_updown counter (
        .clk(clk_slow),
        .ud(ud),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2)
    );

    bcd2seven_seg display (
        .a({Q2, Q1, Q0}),
        .SEG_SEL(SEG_SEL),
        .SEG_DATA(SEG_DATA)
    );
endmodule
