module sign_extend(
    input [15:0] in_instr,
    output [31:0] out_instr
);

    assign out_instr = {{16{in_instr[15]}},in_instr};

endmodule

module tb_sign_extend ();
	reg [15:0] tb_in_instr;
	wire [31:0] tb_out_instr;
	
	initial begin
		tb_in_instr = 16'h7ABC;
		#100 tb_in_instr = 16'hAAAA;
		#100 tb_in_instr = 16'h6D32;
		#100 tb_in_instr = 16'hAAAA;
		#100 tb_in_instr = 16'h3AAA;
		#100 tb_in_instr = 16'h6D32;
	end
	
	sign_extend test_sign_extend(
		.in_instr  (tb_in_instr ),
		.out_instr (tb_out_instr)
	);
	
endmodule