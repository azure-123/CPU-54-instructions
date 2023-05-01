`timescale 1ns / 1ps
module mux4_1(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    input [1:0] choice,
    output [31:0] out_data
    );
    assign out_data=(choice==2'b00)?a:((choice==2'b01)?b:(choice==2'b10)?c:d);
endmodule
