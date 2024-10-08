module ALU_controller(
	input [5:0] funct,
	input [1:0] alu_op,
	output [3:0] operation
);

	assign operation[3] = 1'b0;
	assign operation[2] = (funct[1] & alu_op[1]) | alu_op[0] ;
	assign operation[1] = (~ alu_op[1]) | (~ funct[2]);
	assign operation[0] = (funct[3] | funct[0]) & alu_op[1];
	
endmodule

module tb_ALU_controller();
	reg [5:0] tb_funct;
	reg [1:0] tb_alu_op;
	wire [3:0] tb_operation;
	
	initial begin
		// R-Type Commands
		tb_alu_op = 2'b10;
		tb_funct = 6'b100100; //AND
		#20
		tb_alu_op = 2'b10;
		tb_funct = 6'b100101; //OR
		#20
		tb_alu_op = 2'b10;
		tb_funct = 6'b100000; //ADD
		#20
		tb_alu_op = 2'b10;
		tb_funct = 6'b100010; //SUB
		#20
		tb_alu_op = 2'b10;
		tb_funct = 6'b101010; //SLT
		#20;
		tb_alu_op = 2'b10;
		tb_funct = 6'b100111; //NOR
		#20;			
		// I_type Commands
		// load word
		tb_alu_op = 2'b00;
		tb_funct = 6'bXXXXXX;
		#20
		// store word
		tb_alu_op = 2'b00;
		tb_funct = 6'bXXXXXX;
		#20
		// branch equal to
		tb_alu_op = 2'b01;
		tb_funct = 6'bXXXXXX;
		#20;
	end
	
	ALU_controller test_ALU_controller(
		.funct(tb_funct),
		.alu_op(tb_alu_op),
		.operation(tb_operation)						
	);

endmodule