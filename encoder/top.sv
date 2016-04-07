module top( input logic clock, a_reset, encoder_a, encoder_b, output logic [ 9 : 0 ] coordinate );

	typedef enum logic [ 1 : 0 ] { FORWARD, BACK, IDLE, ERROR } direction;
	direction dir;	
	typedef logic [ 1 : 0 ] state;
	state current_inputs, previous_inputs;
	
	always_ff @( posedge clock or negedge a_reset ) begin
		if ( ~a_reset ) begin
			coordinate = '0;
		end else begin
			current_inputs <= { encoder_a, encoder_b };
			previous_inputs <= current_inputs;
			case ( dir )
				IDLE: begin coordinate <= coordinate; end
				FORWARD: begin coordinate <= coordinate + 10'b1; end
				BACK: begin coordinate <= coordinate - 10'b1; end
				ERROR: begin coordinate <= '0; end
			endcase
		end			
	end
	
	always_comb begin
		case( previous_inputs )
			2'b00: begin 
				case ( current_inputs )
					2'b00: begin dir = IDLE; end
					2'b01: begin dir = BACK; end
					2'b10: begin dir = FORWARD; end
					2'b11: begin dir = ERROR; end
				endcase
			end
			2'b01: begin 
				case ( current_inputs )
					2'b00: begin dir = FORWARD; end
					2'b01: begin dir = IDLE; end
					2'b10: begin dir = ERROR; end
					2'b11: begin dir = BACK; end
				endcase
			end
			2'b10: begin 
				case ( current_inputs )
					2'b00: begin dir = BACK; end
					2'b01: begin dir = ERROR; end
					2'b10: begin dir = IDLE; end
					2'b11: begin dir = FORWARD; end
				endcase
			end
			2'b11: begin 
				case ( current_inputs )
					2'b00: begin dir = ERROR; end
					2'b01: begin dir = FORWARD; end
					2'b10: begin dir = BACK; end
					2'b11: begin dir = IDLE; end
				endcase
			end
		endcase
	end	
endmodule
