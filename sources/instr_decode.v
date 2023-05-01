`timescale 1ns / 1ps

module instr_decode(
    input [31:0] instr_in,
    output reg [54:0] instr_out
    );
    parameter _add  =55'b0000000000000000000000000000000000000000000000000000001;
    parameter _addu =55'b0000000000000000000000000000000000000000000000000000010;
    parameter _sub  =55'b0000000000000000000000000000000000000000000000000000100;
    parameter _subu =55'b0000000000000000000000000000000000000000000000000001000;
    parameter _and  =55'b0000000000000000000000000000000000000000000000000010000;
    parameter _or   =55'b0000000000000000000000000000000000000000000000000100000;
    parameter _xor  =55'b0000000000000000000000000000000000000000000000001000000;
    parameter _nor  =55'b0000000000000000000000000000000000000000000000010000000;
    parameter _slt  =55'b0000000000000000000000000000000000000000000000100000000;
    parameter _sltu =55'b0000000000000000000000000000000000000000000001000000000;
    parameter _sll  =55'b0000000000000000000000000000000000000000000010000000000;
    parameter _srl  =55'b0000000000000000000000000000000000000000000100000000000;
    parameter _sra  =55'b0000000000000000000000000000000000000000001000000000000;
    parameter _sllv =55'b0000000000000000000000000000000000000000010000000000000;
    parameter _srlv =55'b0000000000000000000000000000000000000000100000000000000;
    parameter _srav =55'b0000000000000000000000000000000000000001000000000000000;
    parameter _jr   =55'b0000000000000000000000000000000000000010000000000000000;
    parameter _addi =55'b0000000000000000000000000000000000000100000000000000000;
    parameter _addiu=55'b0000000000000000000000000000000000001000000000000000000;
    parameter _andi =55'b0000000000000000000000000000000000010000000000000000000;
    parameter _ori  =55'b0000000000000000000000000000000000100000000000000000000;
    parameter _xori =55'b0000000000000000000000000000000001000000000000000000000;
    parameter _lw   =55'b0000000000000000000000000000000010000000000000000000000;
    parameter _sw   =55'b0000000000000000000000000000000100000000000000000000000;
    parameter _beq  =55'b0000000000000000000000000000001000000000000000000000000;
    parameter _bne  =55'b0000000000000000000000000000010000000000000000000000000;
    parameter _slti =55'b0000000000000000000000000000100000000000000000000000000;
    parameter _sltiu=55'b0000000000000000000000000001000000000000000000000000000;
    parameter _lui  =55'b0000000000000000000000000010000000000000000000000000000;
    parameter _j    =55'b0000000000000000000000000100000000000000000000000000000;
    parameter _jal  =55'b0000000000000000000000001000000000000000000000000000000;
    parameter _clz  =55'b0000000000000000000000010000000000000000000000000000000;
    parameter _divu =55'b0000000000000000000000100000000000000000000000000000000;
    parameter _eret =55'b0000000000000000000001000000000000000000000000000000000;
    parameter _jalr =55'b0000000000000000000010000000000000000000000000000000000;
    parameter _lb   =55'b0000000000000000000100000000000000000000000000000000000;
    parameter _lbu  =55'b0000000000000000001000000000000000000000000000000000000;
    parameter _lhu  =55'b0000000000000000010000000000000000000000000000000000000;
    parameter _sb   =55'b0000000000000000100000000000000000000000000000000000000;
    parameter _sh   =55'b0000000000000001000000000000000000000000000000000000000;
    parameter _lh   =55'b0000000000000010000000000000000000000000000000000000000;
    parameter _mfc0 =55'b0000000000000100000000000000000000000000000000000000000;
    parameter _mfhi =55'b0000000000001000000000000000000000000000000000000000000;
    parameter _mflo =55'b0000000000010000000000000000000000000000000000000000000;
    parameter _mtc0 =55'b0000000000100000000000000000000000000000000000000000000;
    parameter _mthi =55'b0000000001000000000000000000000000000000000000000000000;
    parameter _mtlo =55'b0000000010000000000000000000000000000000000000000000000;
    parameter _mult =55'b0000000100000000000000000000000000000000000000000000000;
    parameter _multu=55'b0000001000000000000000000000000000000000000000000000000;
    parameter _sysc =55'b0000010000000000000000000000000000000000000000000000000;
    parameter _teq  =55'b0000100000000000000000000000000000000000000000000000000;
    parameter _bgez =55'b0001000000000000000000000000000000000000000000000000000;
    parameter _break=55'b0010000000000000000000000000000000000000000000000000000;
    parameter _div  =55'b0100000000000000000000000000000000000000000000000000000;
    parameter _mul  =55'b1000000000000000000000000000000000000000000000000000000;
    
    
    
    always@(*)
    begin
        casex({instr_in[31:21],instr_in[5:0]})
            17'b000000_?????_100000:instr_out<=_add;
            17'b000000_?????_100001:instr_out<=_addu;
            17'b000000_?????_100010:instr_out<=_sub;
            17'b000000_?????_100011:instr_out<=_subu;
            17'b000000_?????_100100:instr_out<=_and;
            17'b000000_?????_100101:instr_out<=_or;
            17'b000000_?????_100110:instr_out<=_xor;
            17'b000000_?????_100111:instr_out<=_nor;
            17'b000000_?????_101010:instr_out<=_slt;
            17'b000000_?????_101011:instr_out<=_sltu;
            17'b000000_?????_000000:instr_out<=_sll;
            17'b000000_?????_000010:instr_out<=_srl;
            17'b000000_?????_000011:instr_out<=_sra;
            17'b000000_?????_000100:instr_out<=_sllv;
            17'b000000_?????_000110:instr_out<=_srlv;
            17'b000000_?????_000111:instr_out<=_srav;
            17'b000000_?????_001000:instr_out<=_jr;
            17'b001000_?????_??????:instr_out<=_addi;
            17'b001001_?????_??????:instr_out<=_addiu;
            17'b001100_?????_??????:instr_out<=_andi;
            17'b001101_?????_??????:instr_out<=_ori;
            17'b001110_?????_??????:instr_out<=_xori;
            17'b100011_?????_??????:instr_out<=_lw;
            17'b101011_?????_??????:instr_out<=_sw;
            17'b000100_?????_??????:instr_out<=_beq;
            17'b000101_?????_??????:instr_out<=_bne;
            17'b001010_?????_??????:instr_out<=_slti;
            17'b001011_?????_??????:instr_out<=_sltiu;
            17'b001111_?????_??????:instr_out<=_lui;
            17'b000010_?????_??????:instr_out<=_j;
            17'b000011_?????_??????:instr_out<=_jal;
            17'b011100_?????_100000:instr_out<=_clz;
            17'b000000_?????_011011:instr_out<=_divu;
            17'b010000_?????_011000:instr_out<=_eret;
            17'b000000_?????_001001:instr_out<=_jalr;
            17'b100000_?????_??????:instr_out<=_lb;
            17'b100100_?????_??????:instr_out<=_lbu;
            17'b100101_?????_??????:instr_out<=_lhu;
            17'b101000_?????_??????:instr_out<=_sb;
            17'b101001_?????_??????:instr_out<=_sh;
            17'b100001_?????_??????:instr_out<=_lh;
            17'b010000_00000_000000:instr_out<=_mfc0;
            17'b000000_?????_010000:instr_out<=_mfhi;
            17'b000000_?????_010010:instr_out<=_mflo;
            17'b010000_00100_000000:instr_out<=_mtc0;
            17'b000000_?????_010001:instr_out<=_mthi;
            17'b000000_?????_010011:instr_out<=_mtlo;
            17'b000000_?????_011000:instr_out<=_mul;
            17'b000000_?????_011001:instr_out<=_multu;
            17'b000000_?????_001100:instr_out<=_sysc;
            17'b000000_?????_110100:instr_out<=_teq;
            17'b000001_?????_??????:instr_out<=_bgez;
            17'b000000_?????_001101:instr_out<=_break;
            17'b000000_?????_011010:instr_out<=_div;
            17'b011100_?????_000010:instr_out<=_mul;
            default:instr_out<=55'bz;
        endcase
    end
endmodule