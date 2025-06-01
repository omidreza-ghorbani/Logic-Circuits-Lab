module comparator_8bit_chain (
    input [7:0]A,
    input [7:0]B,
    output GT,
    output EQ,
    output LT
);
    wire [2:0] A_high = A[7:5];
    wire [2:0] B_high = B[7:5];
    wire [2:0] A_mid = A[4:2];
    wire [2:0] B_mid = B[4:2];
    wire [2:0] A_low = {1'b0, A[1:0]}; 
    wire [2:0] B_low = {1'b0, B[1:0]};

    wire L0 =1'b0;
    wire E0 = 1'b1;
    wire G0 = 1'b0;
    wire L1, E1, G1;  

    comparator_3bit_chain comp_high (
        .A (A_high),
        .B (B_high),
        .L_in (L0),
        .E_in(E0),
        .G_in (G0),
        .LT(L1),
        .EQ(E1),
        .GT(G1)
    );
    comparator_3bit_chain comp_mid (
        .A (A_mid),
        .B (B_mid),
        .L_in (L1),
        .E_in (E1),
        .G_in (G1),
        .LT (L2),
        .EQ (E2),
        .GT (G2)
    );
    comparator_3bit_chain comp_low (
        .A (A_low),
        .B (B_low),
        .L_in (L2),
        .E_in (E2),
        .G_in (G2),
        .LT (LT),
        .EQ (EQ),
        .GT (GT)
    );

endmodule
