module top (input logic clk, a_reset, button,
					output logic LED);
	
	logic t, ts1, bs1, bs2;
	logic [7 : 0] value, count;
	counter #(8) pwm_count(clk, a_reset, a_reset, count);
	counter #(8) pwm_duty(bs2, a_reset, a_reset, value);
	
	always_comb begin
		if(value != 0) begin
			if (count < value) begin
				t = 1;
			end else begin
				t = 0;
		end else begin
			t = 0;
		end
	end
	
	always_ff @(posedge clk or negedge a_reset) begin
		if(~a_reset) begin
			LED <= 0;
			ts1 <= 0;
			bs1 <= 0;
			bs2 <= 0;
		end else begin
			ts1 <= t;
			LED <= ts1;
			bs1 <= button;
			bs2 <= bs1;
		end
	end

endmodule
