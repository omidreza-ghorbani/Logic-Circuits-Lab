`timescale 1ns / 1ps

module adder_subtractor_gate_delay(
	input wire a,
	input wire b,
	input wire sel,
	input wire cin,
	output wire sum,
	output wire cout
);
wire b_in;
wire axorb,axorbxorcin;
wire aandb,aandcin,bandcin;
xor #(10) (b_in,b,sel);
xor #(10) (axorb,a,b_in);
xor #(10) (sum,axorb,cin);

and #(5)(aandb,a,b_in) ;
and #(5)(aandcin,axorb,cin) ;
or #(5)(cout,aandb,aandcin);
 
endmodule
