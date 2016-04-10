module watches(input clk, a_reset, output [3 : 0] s_o, s_t, m_o, m_t, h_o, h_t);

	always_ff @(posedge clk or negedge a_reset) begin
		if(~a_reset) begin
			s_o <= 0; s_t <= 0;
			m_o <= 0; m_t <= 0;
			h_o <= 0; h_t <= 0;
		end	else begin
			if (s_o == 9) begin
				s_o <= 0;
				if (s_t == 5) begin
					s_t <= 0;
					if (m_o == 9) begin
						m_o <= 0;
						if (m_t == 5) begin
							m_t <= 0;
							if ((h_t == 2) & (h_o == 3)) begin
								h_o <= 0; h_t <= 0;
							end else begin
								if (h_o == 9) begin
									h_o <= 0; h_t <= h_t + 1;
								end else begin
									h_o <= h_o + 1;
								end
							end
						end else begin
							m_t <= m_t + 1;
						end
					end else begin
						m_o <= m_o + 1;
					end
				end else begin
					s_t <= s_t + 1;
				end
			end else begin
				s_o <= s_o + 1;
			end
		end
	end

endmodule
