`timescale 1ns / 1ps
module DIV(
    input rst,
    input [31:0] dividend,
    input [31:0] divisor,
    output [31:0] q,
    output [31:0] r
);
    assign q=$signed(dividend)/$signed(divisor);
    assign r=$signed(dividend)%$signed(divisor);

endmodule
