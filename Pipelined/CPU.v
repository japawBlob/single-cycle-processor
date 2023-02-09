module CPU (clk, reset);
    input clk;
    input reset;

/// INSTRUCTION FETCH WIRES
    wire [31:0] PCPlus4_IF, pc_in, pc_out, instruction_IF;

/// INSTRUCTION DECODE WIRES
    wire [31:0] PCPlus4_ID, instruction_ID, RsD_ID, RtD_ID, SignImm_ID, ImmBranch, PCBranch;
    wire MemToReg_ID, MemWrite_ID, ALUSrc_ID, RegDest_ID, RegWrite_ID, JAL_ID, JR, shift_ID, Branch_ne, Branch_eq, Equals, PCSrc;
    wire [2:0] ALUControl_ID;

/// EXECUTION WIRES
    wire MemToReg_EX, MemWrite_EX, ALUSrc_EX, RegDest_EX, RegWrite_EX, JAL_EX, shift_EX, Zero;
    wire [31:0] RsD_EX, RtD_EX,  SignImm_EX, PCPlus4_EX, SrcA, SrcB, AluOut_EX;
    wire [4:0] shitf_ammount_EX, RsAddr_EX, RtAddr_EX, RdAddr_EX, WriteRegAddr_EX;
    wire [2:0] ALUControl_EX;

/// MEMORY WIRES
    wire RegWrite_MEM, MemToReg_MEM, MemWrite_MEM, JAL_MEM; 
    wire [31:0] AluOut_MEM, RtD_MEM, PCPlus4_MEM, ReadData_MEM, execution_out_MEM;
    wire [4:0] WriteRegAddr_MEM;

/// WRITE BACK WIRES
    wire RegWrite_WB, MemToReg_WB;
    wire [31:0] execution_out_WB, ReadData_WB, Result;
    wire [4:0] WriteRegAddr_WB;

    assign SignImm_shifted = SignImm_ID << 2;

/// INSTRUCTION FETCH
    mux_2_1 pc_mux (PCPlus4_IF, PCBranch, PCSrc, pc_in);                   // PC'
    program_counter program_counter_u (clk, reset, 1'b0 /*stall*/, pc_in, pc_out);      // PC
    imem imem_u (pc_out[9:2], instruction_IF);                             // Instr. Memory
    adder add4 (pc_out, 32'h4, PCPlus4_IF);                                // Adder for PC+4
    IF_ID if_id_u (clk, reset,  PCPlus4_IF, instruction_IF, 1'b0  /*flush*/, 1'b0 /*stall*/, PCPlus4_ID, instruction_ID);

/// INSTRUCTION DECODE
    control_unit control_unit_u (instruction_ID[31:26], instruction_ID[5:0], MemToReg_ID, MemWrite_ID, ALUControl_ID, ALUSrc_ID, RegDest_ID, RegWrite_ID, JAL_ID, JR, shift_ID, Branch_ne, Branch_eq); // Control Unit
    reg_file reg_file_u ( instruction_ID[25:21], instruction_ID[20:16], WriteRegAddr_WB, Result, RegWrite_WB, clk, RsD_ID, RtD_ID ); // Reg. File
    sign_ext sign_ext_u (instruction_ID[15:0], SignImm_ID);                   // sign extender
    adder branch_adder (SignImm_shifted, PCPlus4_ID, ImmBranch);            // Adder for PCBranch
    jump_resolve jump_resolve_u (Equals, JAL_ID, JR, Branch_ne, Branch_eq, PCSrc);
    equal equal_u (RsD_ID, RtD_ID, Equals);
    mux_2_1 branch_result_mux (ImmBranch, RsD_ID, JR, PCBranch);
    ID_EXE id_exe_u(clk, reset, 1'b0 /*stall*/,
              MemToReg_ID, MemWrite_ID, ALUControl_ID, ALUSrc_ID, RegDest_ID, RegWrite_ID, JAL_ID, shift_ID, instruction_ID[10:6],
              RsD_ID, RtD_ID, instruction_ID[25:21], instruction_ID[20:16], instruction_ID[15:11], SignImm_ID, PCPlus4_ID,
              MemToReg_EX, MemWrite_EX, ALUControl_EX, ALUSrc_EX, RegDest_EX, RegWrite_EX, JAL_EX, shift_EX, shitf_ammount_EX,
              RsD_EX, RtD_EX, RsAddr_EX, RtAddr_EX, RdAddr_EX, SignImm_EX, PCPlus4_EX );

/// EXECUTE  
    mux_2_1_5bit write_reg_mux (RtAddr_EX, RdAddr_EX, RegDest_EX, WriteRegAddr_EX); // WriteReg multiplexer
    mux_2_1 SrcA_mux (RsD_EX, { {27{1'b0}}, shitf_ammount_EX}, shift_EX, SrcA); // Mux for shamt to enter ALU
    mux_2_1 SrcB_mux (RtD_EX, SignImm_EX, ALUSrc_EX, SrcB);                      // SrcB Multiplexer
    ALU ALU_u (SrcA, SrcB, ALUControl_EX, Zero, AluOut_EX);                   // ALU
    EXE_MEM exe_mem_u(clk, reset,
               RegWrite_EX, MemToReg_EX, MemWrite_EX, AluOut_EX, WriteRegAddr_EX, RtD_EX, PCPlus4_EX, JAL_EX,
               RegWrite_MEM, MemToReg_MEM, MemWrite_MEM, AluOut_MEM, WriteRegAddr_MEM, RtD_MEM, PCPlus4_MEM, JAL_MEM);

/// MEMORY
    dmem dmem_u ( clk, MemWrite_MEM, AluOut_MEM, RtD_MEM, ReadData_MEM);                // Data Memory
    mux_2_1 result_mux (AluOut_MEM, PCPlus4_MEM, JAL_MEM, execution_out_MEM);
    MEM_WB mem_wb_u (clk, reset, 
              RegWrite_MEM, MemToReg_MEM, execution_out_MEM, ReadData_MEM, WriteRegAddr_MEM,
              RegWrite_WB, MemToReg_WB, execution_out_WB, ReadData_WB, WriteRegAddr_WB);

/// WRITE BACK
    mux_2_1 write_back_mux (execution_out_WB, ReadData_WB, MemToReg_WB, Result);            // Result multiplexer



endmodule