module instruction_memory(
    input [31:0] read_address,
    output [31:0] instruction
);

    reg [31:0] instruction_memory_ROM [17:0];
	
	//Initializing Instruction Memory with test Instructions (Here we test an R-Type Add and Sub Instruction)
	// In practical scenarios, a write enable memory should be used so that processor can write corresponding instructions into
	// the memory. But for simplified implementation, we have used a read-only instruction memory.
	always @(read_address) begin
		instruction_memory_ROM [0] = 32'h012a4020; // 012a4020 = Add $t0,$t1,$t2
		instruction_memory_ROM [1] = 32'h02328022; // 02328022 = Sub $s0,$s1,$s2
		instruction_memory_ROM [2] = 32'h00000000;
		instruction_memory_ROM [3] = 32'h00000000;
		instruction_memory_ROM [4] = 32'h00000000;
		instruction_memory_ROM [5] = 32'h00000000;
		instruction_memory_ROM [6] = 32'h00000000;
		instruction_memory_ROM [7] = 32'h00000000;
		instruction_memory_ROM [8] = 32'h00000000;
		instruction_memory_ROM [9] = 32'h00000000;
		instruction_memory_ROM[10] = 32'h00000000;
		instruction_memory_ROM[11] = 32'h00000000;
		instruction_memory_ROM[12] = 32'h00000000;
		instruction_memory_ROM[13] = 32'h00000000;
		instruction_memory_ROM[14] = 32'h00000000;
		instruction_memory_ROM[15] = 32'h00000000;
		instruction_memory_ROM[16] = 32'h00000000;
		instruction_memory_ROM[17] = 32'h00000000;	
	end
	
	assign instruction = (read_address==32'h003FFFFC) ? 32'h00000000 : instruction_memory_ROM[(read_address - 4194304)/4] ;
    
endmodule

module tb_instruction_memory();
	reg [31:0] tb_read_address;
	wire [31:0] tb_instruction;
	
	integer i;
	initial begin
		tb_read_address = 32'h003FFFFC;
		#25;
		for(i=0; i<18; i=i+1) begin
			tb_read_address = 32'h00400000 | (i*4);
			#25;
		end
	end
	
	instruction_memory test_instruction_memory (
		.read_address(tb_read_address),
		.instruction (tb_instruction )
	);

endmodule