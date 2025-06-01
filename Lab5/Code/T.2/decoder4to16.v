`timescale 1ns / 1ps

module decoder2to4(
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
	
module decoder4to16(
	input a, b, c, d,
	output [0:15]o
	);
	wire w0, w1, w2, w3;
	decoder2to4
		d1(a, b, 1, w0, w1, w2, w3),
		d2(c, d, w0, o[0], o[1], o[2], o[3]),
		d3(c, d, w1, o[4], o[5], o[6], o[7]),
		d4(c, d, w2, o[8], o[9], o[10], o[11]),
		d5(c, d, w3, o[12], o[13], o[14], o[15]);
endmodule
	
module final(
	input a, b, c, d,
	output result
   );
	wire [0:15]o;
	decoder4to16 g(a, b, c, d, o[0:15]);
	or 
		answer(result, o[2], o[3], o[5], o[7], o[11], o[13]);

endmodule
