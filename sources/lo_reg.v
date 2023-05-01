`timescale 1ns / 1ps
module lo_reg(
    input clk,
    input rst,
    input we,
    input [31:0] in_data,
    output [31:0] out_data
    );
    
    reg [31:0]lo;
    always @ (posedge clk or posedge rst) 
    begin
        if (rst) 
        begin
        lo<=32'b0;
        end
        else
        if(we)
        begin
        lo<=in_data;
        end
     end
     assign out_data=lo;
endmodule
