module CPU (clk, reset);
    input clk;
    input reset;

    wire [31:0] pc_mux_out, pc_jr_out, pc_in, pc_out, instruction, PCPlus4, PCBranch, RD1, RD2, WD3, SignImm, SignImm_shifted, SrcA, SrcB, AluOut, ReadData, Result;
    wire PCSrc, Zero, MemToReg, MemWrite, ALUSrc, RegDest, RegWrite, JAL, JR, shift;
    wire [2:0] ALUControl;
    wire [4:0] WriteReg, A3;

    assign SignImm_shifted = SignImm << 2;
    // assign SrcA = RD1; // Placeholder for now - need to be modified for JR



    program_counter program_counter_u (clk, reset, pc_in, pc_out);      // PC
    imem imem_u (pc_out[9:2], instruction);                             // Instr. Memory
    mux_2_1 pc_mux (PCPlus4, PCBranch, PCSrc, pc_mux_out);              // PC'
    mux_2_1 jr_mux (pc_mux_out, RD1, JR, pc_jr_out);                    // JR multiplexer
    mux_2_1 jal_mux (pc_jr_out, { PCPlus4[31:28], instruction[25:0], 2'b00 }, JAL, pc_in); // JAL - PC = (PC & F0000000) | (target << 2)
    adder add4 (pc_out, 32'h4, PCPlus4);                                // Adder for PC+4
    control_unit control_unit_u (instruction[31:26], instruction[5:0], Zero, MemToReg, MemWrite, ALUControl, ALUSrc, RegDest, RegWrite, PCSrc, JAL, JR, shift); // Control Unit
    reg_file reg_file_u ( instruction[25:21], instruction[20:16], A3, WD3, RegWrite, clk, RD1, RD2 ); // Reg. File
    mux_2_1_5bit write_reg_mux (instruction[20:16], instruction[15:11], RegDest, WriteReg); // WriteReg multiplexer
    mux_2_1_5bit write_reg_jal_mux (WriteReg, 5'b11111, JAL, A3);       // multiplexer for saving return adress for JAL
    sign_ext sign_ext_u (instruction[15:0], SignImm);                   // sign extender
    adder branch_adder (SignImm_shifted, PCPlus4, PCBranch);            // Adder for PCBranch
    mux_2_1 SrcA_mux (RD1, { {27{1'b0}}, instruction[10:6]}, shift, SrcA); // Mux for shamt to enter ALU
    mux_2_1 SrcB_mux (RD2, SignImm, ALUSrc, SrcB);                      // SrcB Multiplexer
    ALU ALU_u (SrcA, SrcB, ALUControl, Zero, AluOut);                   // ALU
    mux_2_1 Result_mux (AluOut, ReadData, MemToReg, Result);            // Result multiplexer
    mux_2_1 jal_result_mux (Result, PCPlus4, JAL, WD3);
    dmem dmem_u ( clk, MemWrite, AluOut, RD2, ReadData);                // Data Memory



endmodule