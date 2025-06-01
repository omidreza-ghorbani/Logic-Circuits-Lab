module comparator_3bit_chain (
    input [2:0]A,
    input [2:0] B,
    input L_in,   
    input E_in,    
    input G_in,   
    output GT,      
    output EQ,     
    output LT      
);

    wire eq0=(A[0]==B[0]),
         eq1=(A[1]==B[1]),
         eq2=(A[2]==B[2]);
    wire gt2=A[2]& ~B[2],
         gt1=eq2 & A[1] & ~B[1],
         gt0=eq2 & eq1 & A[0] & ~B[0];
    wire lt2=B[2]&~A[2],
         lt1=eq2& B[1] & ~A[1],
         lt0=eq2 & eq1 & B[0] & ~A[0];

    wire local_EQ = eq0 & eq1 & eq2;
    wire local_GT = gt2 | gt1 | gt0;
    wire local_LT = lt2 | lt1 | lt0;

    assign GT = G_in |(E_in & local_GT);
    assign LT = L_in |(E_in & local_LT);
    assign EQ = E_in & local_EQ;

endmodule