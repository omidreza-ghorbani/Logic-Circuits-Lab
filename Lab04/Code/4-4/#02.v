module main(F, a, b, c);
    input a, b, c;
    output F;
    wire nota, notb, notc, and1, and2, and3, and4;
    
    not(nota, a);
    not(notb, b);
    not(notc, c);
    
    and(and1, nota, notb, notc);
    and(and2, nota, b, c);
    and(and3, a, notb, c);
    and(and4, a, b, notc);
    
    or(F, and1, and2, and3, and4);
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
        $display("Output f1= %b", f);

        a = 0; b = 0; c = 1;
        #10; 
        $display("Output f2= %b", f);

        a = 0; b = 1; c = 0;
        #10; 
        $display("Output f3= %b", f);

        a = 0; b = 1; c = 1;
        #10; 
        $display("Output f4= %b", f);
        
        a = 1; b = 0; c = 0;
        #10; 
        $display("Output f5= %b", f);
        
        a = 1; b = 0; c = 1;
        #10; 
        $display("Output f6= %b", f);
                
        a = 1; b = 1; c = 0;
        #10; 
        $display("Output f7= %b", f);
                
        a = 1; b = 1; c = 1;
        #10; 
        $display("Output f8= %b", f);
        $finish;
    end
endmodule