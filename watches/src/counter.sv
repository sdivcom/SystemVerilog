module counter (input logic clk_i, a_reset_i, s_reset_i, output logic [31 : 0] value_o);

    always_ff @(posedge clk_i, negedge a_reset_i) begin
        if (~a_reset_i) begin
			value_o <= '0;
		end else begin
			if (s_reset_i) begin
				value_o <= value_o + 1'b1;
			end else begin
				value_o <= '0;
			end
        end
    end
endmodule
