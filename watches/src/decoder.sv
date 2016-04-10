module decoder(input logic [3 : 0] sym_i, output logic [7 : 1] led_o);
	always_comb
		case(sym_i) //    abcdefg
			9: led_o = 7'b0000100;
			8: led_o = 7'b0000000;
			7: led_o = 7'b0001111;
			6: led_o = 7'b0100000;
			5: led_o = 7'b0100100;
			4: led_o = 7'b1001100;
			3: led_o = 7'b0000110;
			2: led_o = 7'b0010010;
			1: led_o = 7'b1001111;
			0: led_o = 7'b0000001;
			default: led_o = 7'b1111111;
		endcase
endmodule
