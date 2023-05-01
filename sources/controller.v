`timescale 1ns / 1ps

module controller(
    input clk,
    input z,
    input [54:0] i,
    input neg,
    output PC_CLK,
    output IM_R,
    output M1_1,
    output M1_2,
    output M1_3,
    output M2,
    output M3_1,
    output M3_2,
    output M4_1,
    output M4_2,
    output M4_3,
    output M5,
    output M6_1,
    output M6_2,
    output [1:0] M7,
    output M8,
    output M9_1,
    output M9_2,
    output M10_1,
    output M10_2,
    output [1:0] M11_1,
    output [2:0] M11_2,
    output M12,
    output M12_2,
    output M12_3,
    output [3:0] ALUC,
    output RF_W,
    output RF_CLK,
    output DM_w,
    output DM_r,
    output DM_cs,
    output C_EXT16,
    output hi_ena,
    output lo_ena,
    output start,
    output div_ena,
    output divu_ena,
    output MFC0,
    output MTC0,
    output exception,
    output eret,
    output [4:0] cause
);
    assign _add  =i[0];
    assign _addu =i[1];
    assign _sub  =i[2];
    assign _subu =i[3];
    assign _and  =i[4];
    assign _or   =i[5];
    assign _xor  =i[6];
    assign _nor  =i[7];
    assign _slt  =i[8];
    assign _sltu =i[9];
    assign _sll  =i[10];
    assign _srl  =i[11];
    assign _sra  =i[12];
    assign _sllv =i[13];
    assign _srlv =i[14];
    assign _srav =i[15];
    assign _jr   =i[16];
    assign _addi =i[17];
    assign _addiu=i[18];
    assign _andi =i[19];
    assign _ori  =i[20];
    assign _xori =i[21];
    assign _lw   =i[22];
    assign _sw   =i[23];
    assign _beq  =i[24];
    assign _bne  =i[25];
    assign _slti =i[26];
    assign _sltiu=i[27];
    assign _lui  =i[28];
    assign _j    =i[29];
    assign _jal  =i[30];
    assign _clz  =i[31];
    assign _divu =i[32];
    assign _eret =i[33];
    assign _jalr =i[34];
    assign _lb   =i[35];
    assign _lbu  =i[36];
    assign _lhu  =i[37];
    assign _sb   =i[38];
    assign _sh   =i[39];
    assign _lh   =i[40];
    assign _mfc0 =i[41];
    assign _mfhi =i[42];
    assign _mflo =i[43];
    assign _mtc0 =i[44];
    assign _mthi =i[45];
    assign _mtlo =i[46];
    assign _mult =i[47];
    assign _multu=i[48];
    assign _sysc =i[49];
    assign _teq  =i[50];
    assign _bgez =i[51];
    assign _break=i[52];
    assign _div  =i[53];
    assign _mul  =i[54];


    assign PC_CLK  = clk;
    assign IM_R    = 1;
    assign M1_1    = ~(_j |_jr |_jal|_jalr);
    assign M1_2    =  _jr|_jalr;
    assign M1_3    =  _eret;
    assign M2      = ~(_lw|_lb|_lbu|_lh|_lhu);
    assign M3_1    = _sll|_srl|_sra;//1
    assign M3_2    = _jal|_jalr;
    assign M4_1    = _lui|_addi|_addiu|_andi|_ori|_xori|_lw|_sw|_slti|_sltiu|_lb|_lbu|_lh|_lhu|_sb|_sh;//0
    assign M4_2    = _jal|_jalr;
    assign M4_3    = _bgez;
    assign M5      =(_beq&z)|(_bne&~z)|(_bgez&~neg);
    assign M6_1    = _lui|_addi|_addiu|_andi|_ori|_xori|_lw|_slti|_sltiu|_lb|_lbu|_lh|_lhu|_mfc0;//0
    assign M6_2    =_jal|_jalr;
    assign M7      =(_mult|_mul)?2'b00:(_multu?2'b01:(_div?2'b10:2'b11));
    assign M8      =_clz;
    assign M9_1    =_mfhi;
    assign M9_2    =_mflo|_mul;
    assign M10_1    =_mthi;
    assign M10_2    =_mtlo;
    assign M11_1    =_sw?2'b00:(_sb?2'b01:(_sh?2'b10:2'b11));
    assign M11_2    =_lw?3'b00:(_lbu?3'b01:(_lhu?3'b10:(_lb?3'b11:(_lh?3'b100:3'b101))));
    assign M12      =_mfc0;
    assign M12_2    =0;
    assign M12_3    =_mul;
    assign ALUC[3] =_slt|_sltu|_sll|_srl|_sra|_sllv|_srlv|_srav|_lui|_slti|_sltiu|_bgez;//1
    assign ALUC[2] =_and|_or|_xor|_nor|_sll|_srl|_sra|_sllv|_srlv|_srav|_andi|_ori|_xori;//1
    assign ALUC[1] =_add|_sub|_xor|_nor|_slt|_sltu|_sll|_sllv|_addi|_xori|_slti|_sltiu|_bgez;//1
    assign ALUC[0] =_sub|_subu|_or|_nor|_slt|_srl|_srlv|_ori|_beq|_bne|_slti|_bgez;//0
    assign RF_W=~(_jr|_sw|_beq|_bne|_j|_sb|_sh);//1
    assign RF_CLK  =clk;
    assign DM_cs=_lw|_sw|_lb|_lbu|_lh|_lhu|_sb|_sh;
    assign DM_r=_lw|_lb|_lbu|_lh|_lhu;
    assign DM_w=_sw|_sb|_sh;
    assign C_EXT16 =~(_andi|_ori|_xori|_lui);//1
    assign hi_ena=_mult|_multu|_div|_divu|_mthi|_mul;
    assign lo_ena=_mult|_multu|_div|_divu|_mtlo|_mul;
    assign div_ena=_div;
    assign divu_ena=_divu;
    assign MFC0=_mfc0;
    assign MTC0=_mtc0;
    assign exception=_break|_teq|_sysc;
    assign eret=_eret;
    assign cause=_sysc?5'b01000:(_break?5'b01001:(_teq?5'b01101:5'bz));
endmodule