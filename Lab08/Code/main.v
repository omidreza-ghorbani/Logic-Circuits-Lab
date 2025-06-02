module MUX4to1 (
    input [3:0]w0, w1,w2, w3,
    input [1:0]sel,
    output reg [3:0]y
);
    always @(*) begin
        case (sel)
            2'b00:y=w0;
            2'b01:y=w1;
            2'b10:y=w2;
            2'b11:y= w3;
            default: y=4'b0000;
        endcase
    end
endmodule

module LogicUnit (
    input [1:0]A, B,
    output [3:0]w0, 
    output [3:0]w1
);
    assign w0={2'b00,~A};        
    assign w1={2'b00,~(A&B)}; 
endmodule

module ArithmeticUnit (
    input [1:0]A,B,
    output [3:0]w2, 
    output [3:0]w3
);
    assign w2={2'b00,A+B};      
    assign w3={2'b00, A*B};    
endmodule

module ALU (
    input [1:0]sel,
    input [1:0]A,B,
    output [3:0]Y
);
    wire [3:0] w0, w1,w2, w3;

    LogicUnit logic_unit (
        .A(A),.B(B),
        .w0(w0),
        .w1(w1)
    );

    ArithmeticUnit arithmetic_unit (
        .A(A),.B(B),
        .w2(w2),
        .w3(w3)
    );

    MUX4to1 mux (
        .w0(w0),.w1(w1),.w2(w2), .w3(w3),
        .sel(sel),
        .y(Y)
    );
endmodule
