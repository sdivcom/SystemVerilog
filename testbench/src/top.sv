module top #( parameter WIDTH = 32 ) ( input logic [ WIDTH - 1 : 0 ] a, output logic y );
	assign y = ^a;
endmodule


//_____TESTBENCH_____

module top_tb( );
	timeunit 1ns;
	timeprecision 1ns;
	
	localparam WIDTH = 4;
	
	logic clock, reset;
	
	logic [ WIDTH - 1 : 0 ] a;
	logic y, y_expected;
	
	logic [ WIDTH : 0 ] test_vectors [ 2**WIDTH - 1 : 0 ];
	logic [ 2**WIDTH - 1 : 0 ] vector_num, error_num;
	
	top #( WIDTH ) DUT( a, y );
	
	always begin
		clock = 1; #20ns;
		clock = 0; #20ns;
	end
	
	initial begin
		$readmemb( "../../src/test_vectors.tv", test_vectors );
		$display( "Simulation started at %08t", $time );
		vector_num = 0;
		error_num = 0;
		reset = 0; #50ns;
		reset = 1;
	end
	
	always @(posedge clock) begin
		{ a, y_expected } = test_vectors[ vector_num ];
	end
	
	always @(negedge clock) begin
		if ( reset ) begin
			if ( y !== y_expected ) begin
				$display( "Test %1d failed: inputs %b, outputs y = %b, expected %b", vector_num, a, y, y_expected );
				error_num++;
			end
			vector_num++;
			if ( vector_num >= 2**WIDTH ) begin
				$display( "%1d tests completed with %1d errors", vector_num, error_num );
				#10ns;
				$display( "Simulation stopped at %08t", $time );
				$stop;
			end
		end
	end
endmodule
