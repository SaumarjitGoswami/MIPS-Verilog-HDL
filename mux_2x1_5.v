module mux2x1_5bits (
    input [4:0] in_0,
    input [4:0] in_1,
    input sel,
    output [4:0] out
);

    assign out = (sel) ? in_1 : in_0;
	
endmodule


module tb_mux2x1_5bits();
	reg [4:0] tb_in_0;
    reg [4:0] tb_in_1;
    reg tb_sel;
    wire [4:0] tb_out;
	
	initial begin
		tb_in_0 = 5'h1F;
		tb_in_1 = 5'h00;
		tb_sel = 1'b0;
		#25 tb_sel = 1'b1;
		#25 tb_sel = 1'b0;
		#25;
	end
	
	mux2x1_5bits test_mux2x1_5bits(
		.in_0 (tb_in_0),
		.in_1 (tb_in_1),
		.sel  (tb_sel ),
		.out  (tb_out )
	);
	
endmodule