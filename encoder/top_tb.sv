module top_tb( );
	timeunit 1ns;
	timeprecision 1ns;
	
	logic clock, a_reset, encoder_a, encoder_b;
	logic [ 9 : 0 ] coordinate;
	
	top DUT( clock, a_reset, encoder_a, encoder_b, coordinate );
	
	initial begin
		a_reset = 0;
		clock = 1;
		encoder_a = 0;
		encoder_b = 0;
		#10ns;
		a_reset = 1;
		#1us;
		$stop;
	end
	
	always begin
		encoder_a = 1; encoder_b = 0; #20ns;
		encoder_b = 1; #20ns;
		encoder_a = 0; #20ns;
		encoder_b = 0; #20ns;
	end
	
	always begin
		#5ns clock = ~clock;
	end
	
endmodule
