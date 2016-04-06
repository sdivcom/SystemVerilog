parameter WIDTH = 8;

module top (
	input logic [WIDTH - 1 : 0] first_channel, second_channel, third_channel, fourth_channel,
	input logic [1 : 0] control,
	input logic n_out_enable,
	output tri [WIDTH - 1 : 0] choosed );
	
	mux_4 #( WIDTH ) mux_4_implementation ( .* );

endmodule
