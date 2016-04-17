module VGA_MAIN(CLOCK_50,
					KEY,
					LEDG,
					VGA_HS,
					VGA_VS,
					VGA_R,
					VGA_G,
					VGA_B,
					SW
					);

input CLOCK_50;
input [2:0]KEY;
input [9:0]SW;
output 		[9:0]LEDG;
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output	[3:0]	VGA_R;   				//	VGA Red[3:0]
output	[3:0]	VGA_G;	 				//	VGA Green[3:0]
output	[3:0]	VGA_B;   				//	VGA Blue[3:0]
wire VGA_CLK;
wire H_SYNC_CLK;
wire V_SYNC_CLK;
wire RESET;
wire [10:0]Current_X;
wire [10:0]Current_Y;
wire SYNC_COLOR;
reg	[3:0]	iVGA_R;
reg	[3:0]	iVGA_G;
reg	[3:0]	iVGA_B;
wire	[3:0]	irVGA_R;
wire	[3:0]	irVGA_G;
wire	[3:0]	irVGA_B;
assign irVGA_R[3:0] = iVGA_R[3:0];
assign irVGA_G[3:0] = iVGA_G[3:0];
assign irVGA_B[3:0] = iVGA_B[3:0];
assign RESET = KEY[0];
assign VGA_HS = H_SYNC_CLK;
assign VGA_VS = V_SYNC_CLK;
VGA_PLL		u1
		(	.inclk0(CLOCK_50),
			.c0(VGA_CLK)
		);
VGA_SYNC u2
(	.CLK(VGA_CLK),
	.H_SYNC_CLK(H_SYNC_CLK),
	.V_SYNC_CLK(V_SYNC_CLK),
	.SYNC_RST_N(KEY[0]),
	.oCurrent_X(Current_X),
	.oCurrent_Y(Current_Y),
	.oSYNC_COLOR(SYNC_COLOR));
VGA_OUT u3
(
.oVGA_R(VGA_R[3:0]),
.oVGA_G(VGA_G[3:0]),
.oVGA_B(VGA_B[3:0]),
.iVGA_R(iVGA_R[3:0]),
.iVGA_G(iVGA_G[3:0]),
.iVGA_B(iVGA_B[3:0]),
.VGA_CLK(VGA_CLK),
.Current_X(Current_X),
.Current_Y(Current_Y),
.SYNC_COLOR(SYNC_COLOR),
.RESET(RESET)
);
VGA_BITSTREAM u4(.oRed(irVGA_R),
						.oGreen(irVGA_G),
						.oBlue(irVGA_B),
						.iVGA_X(Current_X),
						.iVGA_Y(Current_Y),
						.iVGA_CLK(VGA_CLK),
						.iRST_n(RESET),
						.iColor_SW(SW[0]));
endmodule
