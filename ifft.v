`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2023 23:40:52
// Design Name: 
// Module Name: main_cordic_fft
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


module ifft (xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,xin9,xin10,xin11,xin12,xin13,xin14,xin15,xin16,
								yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,yin9,yin10,yin11,yin12,yin13,yin14,yin15,yin16,
								clock,
								xout1,xout2,xout3,xout4,xout5,xout6,xout7,xout8,xout9,xout10,xout11,xout12,xout13,xout14,xout15,xout16,
								yout1,yout2,yout3,yout4,yout5,yout6,yout7,yout8,yout9,yout10,yout11,yout12,yout13,yout14,yout15,yout16);

	input signed [15:0] xin1;
	input signed [15:0] xin2;
	input signed [15:0] xin3;
	input signed [15:0] xin4;
	input signed [15:0] xin5;
	input signed [15:0] xin6;
	input signed [15:0] xin7;
	input signed [15:0] xin8;
	input signed [15:0] xin9;
	input signed [15:0] xin10;
	input signed [15:0] xin11;
	input signed [15:0] xin12;
	input signed [15:0] xin13;
	input signed [15:0] xin14;
	input signed [15:0] xin15;
	input signed [15:0] xin16;
	
	input signed [15:0] yin1;
	input signed [15:0] yin2;
	input signed [15:0] yin3;
	input signed [15:0] yin4;
	input signed [15:0] yin5;
	input signed [15:0] yin6;
	input signed [15:0] yin7;
	input signed [15:0] yin8;
	input signed [15:0] yin9;
	input signed [15:0] yin10;
	input signed [15:0] yin11;
	input signed [15:0] yin12;
	input signed [15:0] yin13;
	input signed [15:0] yin14;
	input signed [15:0] yin15;
	input signed [15:0] yin16;
	


output signed [15:0] xout1;
output signed [15:0] xout2;
output signed [15:0] xout3;
output signed [15:0] xout4;
output signed [15:0] xout5;
output signed [15:0] xout6;
output signed [15:0] xout7;
output signed [15:0] xout8;
output signed [15:0] xout9;
output signed [15:0] xout10;
output signed [15:0] xout11;
output signed [15:0] xout12;
output signed [15:0] xout13;
output signed [15:0] xout14;
output signed [15:0] xout15;
output signed [15:0] xout16;

output signed [15:0] yout1;
output signed [15:0] yout2;
output signed [15:0] yout3;
output signed [15:0] yout4;
output signed [15:0] yout5;
output signed [15:0] yout6;
output signed [15:0] yout7;
output signed [15:0] yout8;
output signed [15:0] yout9;
output signed [15:0] yout10;
output signed [15:0] yout11;
output signed [15:0] yout12;
output signed [15:0] yout13;
output signed [15:0] yout14;
output signed [15:0] yout15;
output signed [15:0] yout16;

input clock;

genvar i;

wire signed [31:0] angle_lut [0:7];

assign angle_lut[0] = 'b00000000000000000000000000000000;   // 0
assign angle_lut[1] = 'b00010000000000000000000000000000;   // pi/8
assign angle_lut[2] = 'b00100000000000000000000000000000;   // 2pi/8
assign angle_lut[3] = 'b00110000000000000000000000000000;   // 3pi/8
assign angle_lut[4] = 'b01000000000000000000000000000000;   //
assign angle_lut[5] = 'b01010000000000000000000000000000;   //
assign angle_lut[6] = 'b01100000000000000000000000000000;   //
assign angle_lut[7] = 'b01110000000000000000000000000000;   // 7pi/8

wire signed[15:0] xtemp_in[0:15];
wire signed[15:0] ytemp_in[0:15];

wire signed[15:0] xtemp_out[0:15];
wire signed[15:0] ytemp_out[0:15];

assign {xtemp_in[0],xtemp_in[1],xtemp_in[2],xtemp_in[3],xtemp_in[4],xtemp_in[5],xtemp_in[6],xtemp_in[7],xtemp_in[8],xtemp_in[9],xtemp_in[10],xtemp_in[11],xtemp_in[12],xtemp_in[13],xtemp_in[14],xtemp_in[15]} = {xin1,xin2,xin3,xin4,xin5,xin6,xin7,xin8,xin9,xin10,xin11,xin12,xin13,xin14,xin15,xin16};
assign {ytemp_in[0],ytemp_in[1],ytemp_in[2],ytemp_in[3],ytemp_in[4],ytemp_in[5],ytemp_in[6],ytemp_in[7],ytemp_in[8],ytemp_in[9],ytemp_in[10],ytemp_in[11],ytemp_in[12],ytemp_in[13],ytemp_in[14],ytemp_in[15]} = {yin1,yin2,yin3,yin4,yin5,yin6,yin7,yin8,yin9,yin10,yin11,yin12,yin13,yin14,yin15,yin16};

wire signed[15:0] xtemp1[0:15];
wire signed[15:0] ytemp1[0:15];

wire signed[15:0] xtemp2[0:15];
wire signed[15:0] ytemp2[0:15];

wire signed[15:0] xtemp3[0:15];
wire signed[15:0] ytemp3[0:15];

wire done1[3:0];

generate
for (i=0;i<8;i=i+1)
begin: stage_1butterfly
	butterfly b1(.clock(clock),.xin1(xtemp_in[i]),.yin1(ytemp_in[i]),.xin2(xtemp_in[i+8]),.yin2(ytemp_in[i+8]),.zangle(angle_lut[i]),.xout1(xtemp1[i]),.yout1(ytemp1[i]),.xout2(xtemp1[i+8]),.yout2(ytemp1[i+8]));
end
endgenerate



generate
for (i=0;i<4;i=i+1)
begin: stage_2butterfly
	butterfly b2(.clock(clock),.xin1(xtemp1[i]),.yin1(ytemp1[i]),.xin2(xtemp1[i+4]),.yin2(ytemp1[i+4]),.zangle(angle_lut[2*i]),.xout1(xtemp2[i]),.yout1(ytemp2[i]),.xout2(xtemp2[i+4]),.yout2(ytemp2[i+4]));
	butterfly b3(.clock(clock),.xin1(xtemp1[i+8]),.yin1(ytemp1[i+8]),.xin2(xtemp1[i+12]),.yin2(ytemp1[i+12]),.zangle(angle_lut[2*i]),.xout1(xtemp2[i+8]),.yout1(ytemp2[i+8]),.xout2(xtemp2[i+12]),.yout2(ytemp2[i+12]));
end
endgenerate


generate
for (i=0;i<2;i=i+1)
begin: stage_3butterfly
	butterfly b4(.clock(clock),.xin1(xtemp2[i]),.yin1(ytemp2[i]),.xin2(xtemp2[i+2]),.yin2(ytemp2[i+2]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i]),.yout1(ytemp3[i]),.xout2(xtemp3[i+2]),.yout2(ytemp3[i+2]));
	butterfly b5(.clock(clock),.xin1(xtemp2[i+4]),.yin1(ytemp2[i+4]),.xin2(xtemp2[i+6]),.yin2(ytemp2[i+6]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+4]),.yout1(ytemp3[i+4]),.xout2(xtemp3[i+6]),.yout2(ytemp3[i+6]));
	butterfly b6(.clock(clock),.xin1(xtemp2[i+8]),.yin1(ytemp2[i+8]),.xin2(xtemp2[i+10]),.yin2(ytemp2[i+10]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+8]),.yout1(ytemp3[i+8]),.xout2(xtemp3[i+10]),.yout2(ytemp3[i+10]));
	butterfly b7(.clock(clock),.xin1(xtemp2[i+12]),.yin1(ytemp2[i+12]),.xin2(xtemp2[i+14]),.yin2(ytemp2[i+14]),.zangle(angle_lut[4*i]),.xout1(xtemp3[i+12]),.yout1(ytemp3[i+12]),.xout2(xtemp3[i+14]),.yout2(ytemp3[i+14]));
end
endgenerate

butterfly b8(.clock(clock),.xin1(xtemp3[0]),.yin1(ytemp3[0]),.xin2(xtemp3[1]),.yin2(ytemp3[1]),.zangle(angle_lut[0]),.xout1(xtemp_out[0]),.yout1(ytemp_out[0]),.xout2(xtemp_out[1]),.yout2(ytemp_out[1]));
butterfly b9(.clock(clock),.xin1(xtemp3[2]),.yin1(ytemp3[2]),.xin2(xtemp3[3]),.yin2(ytemp3[3]),.zangle(angle_lut[0]),.xout1(xtemp_out[2]),.yout1(ytemp_out[2]),.xout2(xtemp_out[3]),.yout2(ytemp_out[3]));
butterfly b10(.clock(clock),.xin1(xtemp3[4]),.yin1(ytemp3[4]),.xin2(xtemp3[5]),.yin2(ytemp3[5]),.zangle(angle_lut[0]),.xout1(xtemp_out[4]),.yout1(ytemp_out[4]),.xout2(xtemp_out[5]),.yout2(ytemp_out[5]));
butterfly b11(.clock(clock),.xin1(xtemp3[6]),.yin1(ytemp3[6]),.xin2(xtemp3[7]),.yin2(ytemp3[7]),.zangle(angle_lut[0]),.xout1(xtemp_out[6]),.yout1(ytemp_out[6]),.xout2(xtemp_out[7]),.yout2(ytemp_out[7]));

butterfly b12(.clock(clock),.xin1(xtemp3[8]),.yin1(ytemp3[8]),.xin2(xtemp3[9]),.yin2(ytemp3[9]),.zangle(angle_lut[0]),.xout1(xtemp_out[8]),.yout1(ytemp_out[8]),.xout2(xtemp_out[9]),.yout2(ytemp_out[9]));
butterfly b13(.clock(clock),.xin1(xtemp3[10]),.yin1(ytemp3[10]),.xin2(xtemp3[11]),.yin2(ytemp3[11]),.zangle(angle_lut[0]),.xout1(xtemp_out[10]),.yout1(ytemp_out[10]),.xout2(xtemp_out[11]),.yout2(ytemp_out[11]));
butterfly b14(.clock(clock),.xin1(xtemp3[12]),.yin1(ytemp3[12]),.xin2(xtemp3[13]),.yin2(ytemp3[13]),.zangle(angle_lut[0]),.xout1(xtemp_out[12]),.yout1(ytemp_out[12]),.xout2(xtemp_out[13]),.yout2(ytemp_out[13]));
butterfly b15(.clock(clock),.xin1(xtemp3[14]),.yin1(ytemp3[14]),.xin2(xtemp3[15]),.yin2(ytemp3[15]),.zangle(angle_lut[0]),.xout1(xtemp_out[14]),.yout1(ytemp_out[14]),.xout2(xtemp_out[15]),.yout2(ytemp_out[15]));


assign {xout1,xout2,xout3,xout4,xout5,xout6,xout7,xout8,xout9,xout10,xout11,xout12,xout13,xout14,xout15,xout16} = {xtemp_out[0]>>>4,xtemp_out[8]>>>4,xtemp_out[4]>>>4,xtemp_out[12]>>>4,xtemp_out[2]>>>4,xtemp_out[10]>>>4,xtemp_out[6]>>>4,xtemp_out[14]>>>4,xtemp_out[1]>>>4,xtemp_out[9]>>>4,xtemp_out[5]>>>4,xtemp_out[13]>>>4,xtemp_out[3]>>>4,xtemp_out[11]>>>4,xtemp_out[7]>>>4,xtemp_out[15]>>>4};
assign {yout1,yout2,yout3,yout4,yout5,yout6,yout7,yout8,yout9,yout10,yout11,yout12,yout13,yout14,yout15,yout16} = {ytemp_out[0]>>>4,ytemp_out[8]>>>4,ytemp_out[4]>>>4,ytemp_out[12]>>>4,ytemp_out[2]>>>4,ytemp_out[10]>>>4,ytemp_out[6]>>>4,ytemp_out[14]>>>4,ytemp_out[1]>>>4,ytemp_out[9]>>>4,ytemp_out[5]>>>4,ytemp_out[13]>>>4,ytemp_out[3]>>>4,ytemp_out[11]>>>4,ytemp_out[7]>>>4,ytemp_out[15]>>>4};

//assign yout15=yout15>>1;
endmodule