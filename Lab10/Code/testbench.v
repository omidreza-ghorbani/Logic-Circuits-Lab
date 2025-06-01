`timescale 1ns / 1ps

module DigitalSystem_Top_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [3:0] pass_data;
    reg confirm;
    reg enable;

    // Outputs
    wire [3:0] reg_odd;
    wire [3:0] reg_even;
    wire [2:0] current_state;

    // Instantiate the Unit Under Test (UUT)
    DigitalSystem_Top uut (
        .clk(clk), 
        .reset(reset), 
        .pass_data(pass_data), 
        .confirm(confirm), 
        .enable(enable), 
        .reg_odd(reg_odd), 
        .reg_even(reg_even), 
        .current_state(current_state)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;
        pass_data = 0;
        confirm = 0;
        enable = 0;

        #100;
        reset = 0;
        
        enable = 1;
        pass_data = 4'b1101; 
        #10 confirm = 1;
        #10 confirm = 0;
        #10;
        pass_data = 4'b0101;
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        if (reg_odd !== 4'b0101 || reg_even !== 4'b0000) $display("Error in Test Case 1");
        

        pass_data = 4'b1101;
        #10 confirm = 1;
        #10 confirm = 0;
        #10;
        pass_data = 4'b0110; 
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        if (reg_odd !== 4'b0101 || reg_even !== 4'b0110) $display("Error in Test Case 2");
        
		  
        pass_data = 4'b1010; 
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        if (current_state !== 3'b111) $display("Error in Test Case 3");
        
        reset = 1;
        #10;
        reset = 0;
        #20;
        
        enable = 0;
        pass_data = 4'b1101; 
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        
        enable = 1;
        pass_data = 4'b1101; 
        #10 confirm = 1;
        #10 confirm = 0;
        #10;
        pass_data = 4'b0011; 
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        
        pass_data = 4'b1101;
        #10 confirm = 1;
        #10 confirm = 0;
        #10;
        pass_data = 4'b1000; 
        #10 confirm = 1;
        #10 confirm = 0;
        #20;
        if (reg_odd !== 4'b0011 || reg_even !== 4'b1000) $display("Error in Test Case 7");
        
        $finish;
    end
      
endmodule