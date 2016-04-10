module counter #(parameter WIDTH = 32) (
				input logic clk, a_reset, s_reset,
				output logic [WIDTH - 1 : 0] value);
    
    always_ff @(posedge clk, negedge a_reset) begin
        if (~a_reset) begin 
			value <= '0;
		end else begin
			if (s_reset) begin 
				value <= value + 1'b1;
			end else begin
				value <= '0;
			end
		end
	end
	
endmodule
