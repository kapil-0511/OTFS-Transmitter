`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.08.2023 17:46:21
// Design Name: 
// Module Name: butterfly
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module butterfly(
	input clock,
	input signed [15:0] xin1,
	input signed [15:0] yin1,
	input signed [15:0] xin2,
	input signed [15:0] yin2,
	input signed [31:0] zangle,
	output signed [15:0] xout1,
	output signed [15:0] yout1,
	output signed [15:0] xout2,
	output signed [15:0] yout2,
	output done
   );

wire signed [15:0] xtemp1,xtemp2,ytemp1,ytemp2;
wire done1,done2;

assign xtemp1 = xin1+xin2;
assign ytemp1 = yin1+yin2;

assign xtemp2 = xin1-xin2;
assign ytemp2 = yin1-yin2;

cordic c1(clock,xtemp1,ytemp1,0,xout1,yout1,done1);
cordic c2(clock,xtemp2,ytemp2,zangle,xout2,yout2,done2);

assign done = done1&done2;

endmodule