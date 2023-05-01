`timescale 1ns / 1ps
module MULT(
input clk,		// �˷���ʱ���ź�
input reset,
input [31:0] a, // ���� a(������)
input [31:0] b, // ���� b(����)
output [63:0] z // �˻���� z
) ;
	wire [31:0]a_temp=a[31]?(~a+1):a;
	wire [31:0]b_temp=b[31]?(~b+1):b;
	wire [63:0]temp;
	
	MULTU multu_inst(.clk(clk),.reset(reset),.a(a_temp),.b(b_temp),.z(temp));
	
	assign z=a[31]==b[31]?temp:(~temp+1);
	
endmodule