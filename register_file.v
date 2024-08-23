// `timescale 1ns/1ps

module register_file(
	input clk,
	
    //input from instruction_memory
    input [4:0] read_register_1,
    input [4:0] read_register_2,

    // writing data in register
    input reg_write,
    input [4:0] write_register,
    input [31:0] write_data,

    // register file output
    output [31:0] read_data_1,
    output [31:0] read_data_2
);

    // Register Memory as there are 32 registers in MIPS each of 32-bits
    reg [31:0] register_memory [31:0]; 
	
	
	// Initializing register memory with test data
	initial begin
		register_memory [0] = 32'h00000000;
		register_memory [1] = 32'h11111111;
		register_memory [2] = 32'h22222222;
		register_memory [3] = 32'h33333333;
		register_memory [4] = 32'h44444444;
		register_memory [5] = 32'h55555555;
		register_memory [6] = 32'h66666666;
		register_memory [7] = 32'h77777777;
		register_memory [8] = 32'h00000000;// $t0 register
		register_memory [9] = 32'h00000001;// $t1 register
		register_memory[10] = 32'h00000002;// $t2 register
		register_memory[11] = 32'hbbbbbbbb;// 
		register_memory[12] = 32'hcccccccc;// 
		register_memory[13] = 32'hdddddddd;// 
		register_memory[14] = 32'heeeeeeee;// 
		register_memory[15] = 32'hffffffff;// 
		register_memory[16] = 32'h11111111;// $s0 register
		register_memory[17] = 32'h22222222;// $s1 register
		register_memory[18] = 32'h22222222;// $s2 register
		register_memory[19] = 32'h33333333;
		register_memory[20] = 32'h44444444;
		register_memory[21] = 32'h55555555;
		register_memory[22] = 32'h66666666;
		register_memory[23] = 32'h77777777;
		register_memory[24] = 32'h88888888;
		register_memory[25] = 32'h99999999;
		register_memory[26] = 32'haaaaaaaa;
		register_memory[27] = 32'hbbbbbbbb;
		register_memory[28] = 32'h10008000;
		register_memory[29] = 32'h7ffff1ec;
		register_memory[30] = 32'heeeeeeee;
		register_memory[31] = 32'hffffffff;
	end

    always @(posedge clk)
        if(reg_write)
            register_memory[write_register] = write_data; // if reg_write is 1 then write data wriiten to write register of register memory

    assign read_data_1 = register_memory[read_register_1];
    assign read_data_2 = register_memory[read_register_2];
	
endmodule

module tb_register_file();
	reg         tb_clk				;
    reg [4:0]   tb_read_register_1  ;
    reg [4:0]   tb_read_register_2  ;
    reg         tb_reg_write        ;
    reg [4:0]   tb_write_register   ;
    reg [31:0]  tb_write_data       ;
    wire [31:0] tb_read_data_1      ;
    wire [31:0] tb_read_data_2      ;
	
	initial begin 
		tb_clk = 0;
		repeat (500) begin 
			#5 tb_clk = ~ tb_clk;
		end
	end
	
	integer i;
    initial begin
		tb_read_register_1 = 0;
		tb_read_register_2 = 0;
		tb_write_register = 5'd8;
		tb_reg_write = 0;
		tb_write_data = 32'ha5a5a5a5;
		#10 tb_read_register_1 = 1;
		#10 tb_read_register_1 = 2;
		#10 tb_read_register_1 = 3;
		#10 tb_read_register_1 = 4;
        #10 tb_read_register_1 = 8;
				
        for (i=0; i<32; i=i+1 ) begin
            tb_read_register_1 = i;
            tb_read_register_2 = i+1;
            #25;
        end  
		tb_read_register_1 = 8;
		tb_read_register_2 = 8;
		#50 tb_reg_write = 1'b1;
		#10 tb_reg_write = 1'b0;
		#10 tb_read_register_1 = 9;
		#10 tb_read_register_1 = 8;
		#30;
		// $finish;
    end


    register_file test_register_file (
		.clk 			 (tb_clk            ),
		.read_register_1 (tb_read_register_1),
		.read_register_2 (tb_read_register_2),
		.reg_write       (tb_reg_write      ),
		.write_register  (tb_write_register ),
		.write_data      (tb_write_data     ),
		.read_data_1     (tb_read_data_1    ),
		.read_data_2     (tb_read_data_2    )
	);

endmodule