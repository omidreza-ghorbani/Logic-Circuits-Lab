module main(F, a, b, c);
    input a, b, c;
    output F;
    xnor(F, a, b, c);
endmodule

module testbench;
    reg a, b, c;  
    wire f;

    main uut (
        .F(f),
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        a = 0; b = 0; c = 0;
        #10; 
        $display("f1 = %b", f);

        a = 0; b = 0; c = 1;
        #10; 
        $display("f2 = %b", f);

        a = 0; b = 1; c = 0;
        #10; 
        $display("f3 = %b", f);

        a = 0; b = 1; c = 1;
        #10; 
        $display("f4 = %b", f);
        
        a = 1; b = 0; c = 0;
        #10; 
        $display("f5 = %b", f);
        
        a = 1; b = 0; c = 1;
        #10; 
        $display("f6 = %b", f);
                
        a = 1; b = 1; c = 0;
        #10; 
        $display("f7 = %b", f);
                
        a = 1; b = 1; c = 1;
        #10; 
        $display("f8 = %b", f);
        
        $finish;
    end
endmodule