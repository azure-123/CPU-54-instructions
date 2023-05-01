`timescale 1ns / 1ps
module mux5_1(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    input [31:0] e,
    input [2:0] choice,
    output [31:0] out_data
    );
    assign out_data=(choice==3'b00)?a:((choice==3'b01)?b:(choice==3'b10)?c:(choice==3'b11)?d:e);
endmodule
