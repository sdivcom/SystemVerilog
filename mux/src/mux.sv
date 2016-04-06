module mux_2 #( parameter WIDTH = 32 ) (
	input logic [WIDTH - 1 : 0] first_channel, second_channel,
	input logic control, n_out_enable,
	output tri [WIDTH - 1 : 0] choosed );
	
	always_comb begin
		if ( ~n_out_enable ) begin
			choosed = control ? first_channel : second_channel;
		end else begin
			choosed = 'z;
		end
	end

endmodule

module mux_4 #( parameter WIDTH = 32 ) (
	input logic [WIDTH - 1 : 0] first_channel, second_channel, third_channel, fourth_channel,
	input logic [1 : 0] control,
	input logic n_out_enable,
	output tri [WIDTH - 1 : 0] choosed );
	
	logic [WIDTH - 1 : 0] first_mux_out, second_mux_out;
	
	mux_2 #( WIDTH ) first_mux( .*, .control( control[0] ), .choosed( first_mux_out ) );
	mux_2 #( WIDTH ) second_mux( third_channel, fourth_channel, control[0], n_out_enable, second_mux_out );
	mux_2 #( WIDTH ) result_mux( first_mux_out, second_mux_out, control[1], n_out_enable, choosed );
endmodule
