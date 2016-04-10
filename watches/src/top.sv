module top(input logic clk_i, a_reset_i,
			output logic [7 : 1] led_o,
			output logic [5 : 0] dig_o);
		
	logic [31 : 0] count, count2, count3;
	logic [3 : 0] s_o, s_t, m_o, m_t, h_o, h_t;
	logic [3 : 0] sym_i, sym_o;
	assign sym_i = sym_o;
	logic cmp, cmp2, seconds;
	assign cmp = ~(count == 49999998);
	assign cmp2 = ~(count2 == 10000);
	assign seconds = ~(count == 4999999);
	logic cmp_sync, cmp2_sync, seconds_sync;
	
	always_ff @(posedge clk_i) begin
		cmp_sync <= cmp;
		cmp2_sync <= cmp2;
		seconds_sync <= seconds;
	end
	
	counter cnt(clk_i, a_reset_i, cmp_sync, count);
	counter cnt2(clk_i, a_reset_i, cmp2_sync, count2);
	counter cnt3(clk_i, a_reset_i, seconds_sync, count3);
	watches w(seconds_sync, a_reset_i, s_o, s_t, m_o, m_t, h_o, h_t);
	display disp(cmp2_sync, a_reset_i, s_o, s_t, m_o, m_t, h_o, h_t, dig_o, sym_o);
	decoder dec(sym_i, led_o);
	
endmodule
