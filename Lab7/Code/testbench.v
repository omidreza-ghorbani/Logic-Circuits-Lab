`timescale 1ns / 1ps


module tb1;

	reg a;
	reg b;
	reg sel;
	reg cin;

	wire sum;
	wire cout;

	adder_subtractor_gate_delay uut (
		.a(a), 
		.b(b), 
		.sel(sel), 
		.cin(cin), 
		.sum(sum), 
		.cout(cout)
	);

	initial begin
		a = 0;
		b = 0;
		sel = 0;
		cin = 0;

		#100;
	
		a = 1'b1 ; b = 1'b1 ; sel = 1'b1; #30
	
		a = 1'b1 ; b = 1'b0 ; sel = 1'b0; #30		
	$finish;
	end
      
endmodule

