`timescale 1ns / 1ps
module DMEM(
    input clk,
    input ena,
    input rst,
    input [1:0] ssignal,
    input [2:0] lsignal,
    input write,
    input read,
    input [10:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
);

    reg [7:0] data[0:1023];
    
    always @ (negedge clk) 
    begin
        if(rst)
        begin
        data[0]<=0;
        data[1]<=0;
        data[2]<=0;
        data[3]<=0;
        data[4]<=0;
        data[5]<=0;
        data[6]<=0;
        data[7]<=0;
        data[8]<=0;
        data[9]<=0;
        data[10]<=0;
        data[11]<=0;
        data[12]<=0;
        data[13]<=0;
        end
        if (write && ena) 
        begin
        if(ssignal==2'b00)
        begin
            data[addr] <= wdata[7:0];
            data[addr+1] <= wdata[15:8];
            data[addr+2] <= wdata[23:16];
            data[addr+3] <= wdata[31:24];
        end
        else if(ssignal==2'b01)
            data[addr] <=wdata[7:0];
        else if(ssignal==2'b10)
        begin
            data[addr] <= wdata[7:0];
            data[addr+1] <= wdata[15:8];
        end
        else
        ;
        end
    end
    
//    assign rdata = (read && ena) ? (ssignal==2'b00?{data[addr+3],data[addr+2],data[addr+1],data[addr]}:
//                                   ssignal==2'b01?{8'b0,data[addr+2],data[addr+1],data[addr]} :
//                                   ssignal==2'b10?{16'b0,data[addr+1],data[addr]}: 32'bz);
     assign rdata =((read && ena) ? (lsignal==3'b00)?{data[addr+3],data[addr+2],data[addr+1],data[addr]}:
                                   ((lsignal==3'b01||lsignal==3'b11)?{24'b0,data[addr]}:
                                   ((lsignal==3'b10||lsignal==3'b100)?{16'b0,data[addr+1],data[addr]}:32'bz)):32'bz);
endmodule