module mux2x1_32bits (
    input [31:0] in_0,
    input [31:0] in_1,
    input sel,
    output [31:0] out 
);

    assign out = (sel) ? in_1 : in_0;

endmodule


module tb_mux2x1_32bits();
	reg [31:0] tb_in_0;
    reg [31:0] tb_in_1;
    reg tb_sel;
    wire [31:0] tb_out;
	
	initial begin
		tb_in_0 = 32'hFFFFFFFF;
		tb_in_1 = 32'h00000000;
		tb_sel = 1'b0;
		#25 tb_sel = 1'b1;
		#25 tb_sel = 1'b0;
		#25;
	end
	
	mux2x1_32bits test_mux2x1_32bits(
		.in_0 (tb_in_0),
		.in_1 (tb_in_1),
		.sel  (tb_sel ),
		.out  (tb_out )
	);
	
endmodule