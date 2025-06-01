`timescale 1ns / 1ps

module decoder4to2(
	input a, b, enable, 
	output o0, o1, o2, o3
	);
	wire notA, notB;
	not 
		n1(notA, a),
		n2(notB, b);
	and 
		a1(o0, notA, notB, enable),
		a2(o1, notA, b, enable),
		a3(o2, a, notB, enable),
		a4(o3, a, b, enable);
endmodule
