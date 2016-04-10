module display(input clk_i, a_reset_i, input [3 : 0] s_o, s_t, m_o, m_t, h_o, h_t, 
				output [5 : 0] dig_o, output [3 : 0] sym);

	typedef enum logic [2 : 0] {si, fi, fo, th, tw, on, no} state;
	state disp;
	
	always_ff @(posedge clk_i or negedge a_reset_i) begin
		if(~a_reset_i) begin
			disp <= si;
		end else begin
			case(disp)
				si: begin disp <= fi; end
				fi: begin disp <= fo; end
				fo: begin disp <= th; end
				th: begin disp <= tw; end
				tw: begin disp <= on; end
				on: begin disp <= si; end
				default: begin disp <= no; end
			endcase
		end
	end
	
	always_comb begin
		case(disp)
			si: begin dig_o = 6'b011111; sym = h_t; end
			fi: begin dig_o = 6'b101111; sym = h_o; end
			fo: begin dig_o = 6'b110111; sym = m_t; end
			th: begin dig_o = 6'b111011; sym = m_o; end
			tw: begin dig_o = 6'b111101; sym = s_t; end
			on: begin dig_o = 6'b111110; sym = s_o; end
			no: begin dig_o = '1; sym = '1; end
			default: begin dig_o <= '1; sym = '1; end
		endcase
	end
	
endmodule
