`timescale 1ns / 1ps

module cpu(
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,
    output [31:0] pc,
    output [31:0] DM_addr,
    output [31:0] DM_wdata,
    output        DM_CS,
    output        DM_R,
    output        DM_W,
    output [1:0] ssignal,
    output [2:0] lsignal
);
    
    wire PC_CLK;                     
    wire PC_ENA;                     
    wire M1_1,M1_2,M1_3, M2, M3_1,M3_2, M4_1,M4_2,M4_3,M5,M6_1, M6_2,M8,M9_1,M9_2,M10_1,M10_2,M12,M12_2,M12_3;
    wire [1:0] M11_1;
    wire [2:0] M11_2;
    wire [1:0] M7;                        
    wire [3:0] ALUC;                 
    wire RF_W;                       
    wire RF_CLK;                     
    wire C_EXT16;                    
    wire hi_ena;
    wire lo_ena;
    wire MFC0,MTC0;
 
                              
    
    wire [54:0] ins_code;                 
    
    wire [31:0] ALU;               
    wire [31:0] PC;                
    wire [31:0] RF;                
    wire [31:0] Rs;                
    wire [31:0] Rt;                
    wire [31:0] IM;                
    wire [31:0] DM;                
    wire [31:0] Mux1_1;              
    wire [31:0] Mux1_2;              
    wire [31:0] Mux1_3;                            
    wire [31:0] Mux2;              
    wire [31:0] Mux3_1;              
    wire [31:0] Mux3_2;              
    wire [31:0] Mux4_1;                          
    wire [31:0] Mux4_2;                          
    wire [31:0] Mux4_3;                          
    wire [31:0] Mux5;                          
    wire [4:0]  Mux6_1;              
    wire [4:0]  Mux6_2;              
    wire [31:0] Mux7_1;              
    wire [31:0] Mux7_2;              
    wire [31:0] Mux7;              
    wire [31:0] Mux8;              
    wire [31:0] Mux9_1;              
    wire [31:0] Mux9_2;              
    wire [31:0] Mux10_1;             
    wire [31:0] Mux10_2;             
    wire [31:0] Mux11_1;             
    wire [31:0] Mux11_2;             
    wire [31:0] Mux12;             
    wire [31:0] Mux12_2;             
    wire [31:0] Mux12_3;             
//    wire        Mux11;             
                                      
    wire [31:0] EXT1;              
    wire [31:0] EXT5;              
    wire [31:0] EXT16;             
    wire [31:0] EXT18;             
    wire [31:0] ADD;               
    wire [31:0] ADD8;              
    wire [31:0] NPC;               
    wire [31:0] ii;
    wire [31:0] CP0_out;
        
    wire zero;                       
    wire carry;                      
    wire negative;                   
    wire overflow; 
    //hi lo registers
    wire hi_w;
    wire lo_w;
    wire start,div_busy,divu_busy;
    wire [63:0] multu_result;
    wire [63:0] mult_result;
    wire [31:0] div_q;
    wire [31:0] div_r;
    wire [31:0] divu_q;
    wire [31:0] divu_r;
    wire [31:0] hi_data;
    wire [31:0] lo_data;
    wire div_ena,divu_ena;
    
    //clz
    wire [5:0] zeros;
    //cp0
    wire exception;
    wire eret;
    wire [4:0] cause;
    wire [31:0] status;
    wire [31:0] exc_addr;
    
    wire [31:0] temp_out;
    
                   
    assign PC_ENA = 1;
    
    assign pc = PC;
    assign DM_addr = ALU;
    assign DM_wdata = Mux11_1;
    assign ssignal=M11_1;
    assign lsignal=M11_2;
    
    instr_decode cpu_inst (.instr_in(inst), .instr_out(ins_code));
    controller cpu_control (.clk(clk), .z(zero), .i(ins_code),.neg(negative), .PC_CLK(PC_CLK), 
        .IM_R(IM_R), .M1_1(M1_1), .M1_2(M1_2),.M1_3(M1_3), .M2(M2), .M3_1(M3_1), .M3_2(M3_2), .M4_1(M4_1), .M4_2(M4_2), .M4_3(M4_3),.M5(M5), .M6_1(M6_1),.M6_2(M6_2),.M7(M7),.M8(M8),
        .M9_1(M9_1),.M9_2(M9_2),.M10_1(M10_1),.M10_2(M10_2), .M11_1(M11_1),.M11_2(M11_2),.M12(M12),.M12_2(M12_2),.M12_3(M12_3),
        .ALUC(ALUC), .RF_W(RF_W), .RF_CLK(RF_CLK), .DM_w(DM_W), .DM_r(DM_R), .DM_cs(DM_CS), .C_EXT16(C_EXT16),.hi_ena(hi_ena),.lo_ena(lo_ena),
        .div_ena(div_ena),.divu_ena(divu_ena),.MFC0(MFC0),.MTC0(MTC0),.exception(exception),.eret(eret),.cause(cause)
    );
    pcreg cpu_pc (.clk(PC_CLK), .rst(reset), .ena(PC_ENA),.data_in(Mux1_3), .data_out(PC));
    pcreg temp(.clk(PC_CLK),.rst(reset),.ena(~M12_2),.data_in(Rs),.data_out(temp_out));
    npc cpu_npc  (.in(PC), .out(NPC));
    alu cpu_alu (.a(Mux3_2), .b(Mux4_3),.aluc(ALUC), .r(ALU),.zero(zero), .carry(carry), .negative(negative), .overflow(overflow));
    II cpu_ii(.a(PC[31:28]),.b(inst[25:0]),.out_data(ii));
    mux cpu_mux1_1(.a(ii),.b(Mux5),.choice(M1_1),.out_data(Mux1_1));
    mux cpu_mux1_2(.a(Mux1_1),.b(Rs),.choice(M1_2),.out_data(Mux1_2));
    mux cpu_mux1_3(.a(Mux1_2),.b(exc_addr),.choice(M1_3),.out_data(Mux1_3));
    mux cpu_mux2(.a(Mux11_2),.b(ALU),.choice(M2),.out_data(Mux2));
    mux cpu_mux3_1(.a(Rs),.b(EXT5),.choice(M3_1),.out_data(Mux3_1));
    mux cpu_mux3_2(.a(Mux3_1),.b(PC),.choice(M3_2),.out_data(Mux3_2));
    mux cpu_mux4_1(.a(Rt),.b(EXT16),.choice(M4_1),.out_data(Mux4_1));
    mux cpu_mux4_2(.a(Mux4_1),.b(32'd4),.choice(M4_2),.out_data(Mux4_2));
    mux cpu_mux4_3(.a(Mux4_2),.b(32'd0),.choice(M4_3),.out_data(Mux4_3));
    mux cpu_mux5(.a(NPC),.b(ADD),.choice(M5),.out_data(Mux5));
    mux_5bits cpu_mux6_1(.a(inst[15:11]),.b(inst[20:16]),.choice(M6_1),.out_data(Mux6_1));
    mux_5bits cpu_mux6_2(.a(Mux6_1),.b(5'd31),.choice(M6_2),.out_data(Mux6_2));
    mux4_1 cpu_mux7_1(.a(mult_result[31:0]),.b(multu_result[31:0]),.c(div_q),.d(divu_q),.choice(M7),.out_data(Mux7_1));//connected to lo
    mux4_1 cpu_mux7_2(.a(mult_result[63:32]),.b(multu_result[63:32]),.c(div_r),.d(divu_r),.choice(M7),.out_data(Mux7_2));//connected to hi
    mux cpu_mux8(.a(Mux2),.b({26'b0,zeros}),.choice(M8),.out_data(Mux8));
    mux cpu_mux9_1(.a(Mux8),.b(hi_data),.choice(M9_1),.out_data(Mux9_1));
    mux cpu_mux9_2(.a(Mux9_1),.b(lo_data),.choice(M9_2),.out_data(Mux9_2));
    mux cpu_mux10_1(.a(Mux7_2),.b(Rs),.choice(M10_1),.out_data(Mux10_1));
    mux cpu_mux10_2(.a(Mux7_1),.b(Rs),.choice(M10_2),.out_data(Mux10_2));
    mux4_1 cpu_mux11_1(.a(Rt),.b({24'b0,Rt[7:0]}),.c({16'b0,Rt[15:0]}),.d(32'bz),.choice(M11_1),.out_data(Mux11_1));
    mux5_1 cpu_mux11_2(.a(rdata),.b({24'b0,rdata[7:0]}),.c({16'b0,rdata[15:0]}),.d({{24{rdata[7]}},rdata[7:0]}),.e({{16{rdata[15]}},rdata[15:0]}),.choice(M11_2),.out_data(Mux11_2));
    mux cpu_mux12(.a(Mux9_2),.b(CP0_out),.choice(M12),.out_data(Mux12));
    mux cpu_mux12_2(.a(Mux12),.b(temp_out),.choice(M12_2),.out_data(Mux12_2));
    mux cpu_mux12_3(.a(Mux12_2),.b(Mux10_2),.choice(M12_3),.out_data(Mux12_3));
    ext5 cpu_ext5(.a(inst[10:6]),.b(EXT5));
    ext16 cpu_ext16 (.a(inst[15:0]), .sext(C_EXT16), .b(EXT16));
    ext18 cpu_ext18(.a(inst[15:0]),.b(EXT18));
    add cpu_add(.add_1(EXT18),.add_2(NPC),.out_data(ADD));
    regfile cpu_ref(.clk(RF_CLK),.rst(reset), .we(RF_W),.Rsc(inst[25:21]), .Rtc(inst[20:16]), .Rdc(Mux6_2),.Rs(Rs), .Rt(Rt), .Rd(Mux12_3));
    MULTU cpu_multu(.clk(clk),.reset(reset),.a(Rs),.b(Rt),.z(multu_result));
    MULT cpu_mult(.clk(clk),.reset(reset),.a(Rs),.b(Rt),.z(mult_result));
    DIVU cpu_divu(.rst(rst),.dividend(Rs),.divisor(Rt),.q(divu_q),.r(divu_r));
    DIV cpu_div(.rst(rst),.dividend(Rs),.divisor(Rt),.q(div_q),.r(div_r));
    hi_reg cpu_hi(.clk(clk),.rst(reset),.we(hi_ena),.in_data(Mux10_1),.out_data(hi_data));
    lo_reg cpu_lo(.clk(clk),.rst(reset),.we(lo_ena),.in_data(Mux10_2),.out_data(lo_data));
    clz cpu_clz(.in_data(Rs),.zeros(zeros));
    CP0 cpu_cp0(.clk(clk),.rst(reset),.mfc0(MFC0),.mtc0(MTC0),.pc(PC),.Rd(inst[15:11]),.wdata(Rt),.exception(exception),.eret(eret),.cause(cause),.rdata(CP0_out),.status(status),.exc_addr(exc_addr));
    
endmodule