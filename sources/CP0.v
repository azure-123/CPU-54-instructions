`timescale 1ns / 1ps

module CP0(
    input clk,
    input rst,
    input mfc0,//¶Á
    input mtc0,//Ğ´
    input [31:0] pc,
    input [4:0] Rd,
    input [31:0] wdata,
    input exception,
    input eret,
    input [4:0] cause,
    output [31:0] rdata,
    output [31:0] status,
    output [31:0] exc_addr
    );
    
    reg [31:0] array_reg [31:0];
    reg [36:0] temp;    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            array_reg[0]  <= 32'b0;
            array_reg[1]  <= 32'b0;
            array_reg[2]  <= 32'b0;
            array_reg[3]  <= 32'b0;
            array_reg[4]  <= 32'b0;
            array_reg[5]  <= 32'b0;
            array_reg[6]  <= 32'b0;
            array_reg[7]  <= 32'b0;
            array_reg[8]  <= 32'b0;
            array_reg[9]  <= 32'b0;
            array_reg[10] <= 32'b0;
            array_reg[11] <= 32'b0;
            array_reg[12] <= 32'b0;
            array_reg[13] <= 32'b0;
            array_reg[14] <= 32'b0;
            array_reg[15] <= 32'b0;
            array_reg[16] <= 32'b0;
            array_reg[17] <= 32'b0;
            array_reg[18] <= 32'b0;
            array_reg[19] <= 32'b0;
            array_reg[20] <= 32'b0;
            array_reg[21] <= 32'b0;
            array_reg[22] <= 32'b0;
            array_reg[23] <= 32'b0;
            array_reg[24] <= 32'b0;
            array_reg[25] <= 32'b0;
            array_reg[26] <= 32'b0;
            array_reg[27] <= 32'b0;
            array_reg[28] <= 32'b0;
            array_reg[29] <= 32'b0;
            array_reg[30] <= 32'b0;
            array_reg[31] <= 32'b0;
        end
        else
        begin
            if(mtc0)
                array_reg[Rd]<=wdata;
            if(exception)
            begin
                array_reg[12]<={array_reg[12][26:0],5'b0};
                array_reg[13]<={25'b0,cause,2'b0};
                array_reg[14]<=pc-4;
            end
            if(eret)
                array_reg[12]<={5'b0,array_reg[12][31:5]};
        end
    end

    
    assign status=array_reg[12];
    assign exc_addr=array_reg[14];
    assign rdata=mfc0?array_reg[Rd]:32'bz;
endmodule
