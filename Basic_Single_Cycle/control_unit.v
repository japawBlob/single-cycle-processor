module control_unit (Opcode, Funct, Zero,
        MemToReg, MemWrite, ALUControl, ALUSrc, RegDest, RegWrite, PCSrc, JAL, JR, shift);
    input [5:0] Opcode, Funct;
    input Zero;
    output MemToReg, MemWrite, ALUSrc, RegDest, RegWrite, PCSrc, JAL, JR, shift;
    output [2:0] ALUControl;
    
    wire [1:0] ALUOp;
    wire Branch_eq, Branch_ne;

    main_decoder m_dec (Opcode, Branch_eq, Branch_ne, MemToReg, ALUSrc, RegDest, RegWrite, MemWrite, ALUOp, JAL);

    alu_decoder a_dec (Funct, ALUOp, ALUControl, JR, shift);

    assign PCSrc = Zero & Branch_eq | ~Zero & Branch_ne;

endmodule