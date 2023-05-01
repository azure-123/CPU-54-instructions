`timescale 1ns / 1ps
module DIVU(
    input rst,
    input [31:0] dividend,
    input [31:0] divisor,
    output [31:0] q,
    output [31:0] r
);
    assign q=dividend/divisor;
    assign r=dividend%divisor;

endmodule
