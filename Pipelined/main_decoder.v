module main_decoder (Opcode, Branch_eq, Branch_ne, MemToReg, ALUSrc, RegDest, RegWrite, MemWrite, ALUOp, JAL);
    input [5:0] Opcode;
    output Branch_eq, Branch_ne, MemToReg, ALUSrc, RegDest, RegWrite, MemWrite, JAL;
    output [1:0] ALUOp;

    reg Branch_eq_l, Branch_ne_l, MemToReg_l, ALUSrc_l, RegDest_l, RegWrite_l, MemWrite_l, JAL_l;
    reg [1:0] ALUOp_l;

    always @(*) begin
        case (Opcode)
            6'b000000:      // ADD, AND, OR, SLT, SLL, SRL, SUB, JR
                begin
                    RegWrite_l = 1'b1;
                    RegDest_l = 1'b1;
                    ALUSrc_l = 1'b0;
                    ALUOp_l = 2'b10;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b0;
                    JAL_l = 1'b0;
                end
            6'b001000:      // ADDI 
                begin
                    RegWrite_l = 1'b1;
                    RegDest_l = 1'b0;
                    ALUSrc_l = 1'b1;
                    ALUOp_l = 2'b00;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b0;
                    JAL_l = 1'b0;
                end
            6'b000100:      // BEQ 
                begin
                    RegWrite_l = 1'b0;
                    RegDest_l = 1'b0;
                    ALUSrc_l = 1'b0;
                    ALUOp_l = 2'b01;
                    Branch_eq_l = 1'b1;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b0; 
                    JAL_l = 1'b0;
                end
            6'b000101:      // BNE
                begin
                    RegWrite_l = 1'b0;
                    RegDest_l = 1'b0;
                    ALUSrc_l = 1'b0;
                    ALUOp_l = 2'b01;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b1;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b0; 
                    JAL_l = 1'b0;
                end
            6'b100011:      // LW
                begin
                    RegWrite_l = 1'b1;
                    RegDest_l = 1'b0;
                    ALUSrc_l = 1'b1;
                    ALUOp_l = 2'b00;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b1;
                    JAL_l = 1'b0;
                end
            6'b101011:      // SW
                begin
                    RegWrite_l = 1'b0;
                    RegDest_l = 1'b0;
                    ALUSrc_l = 1'b1;
                    ALUOp_l = 2'b00;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b1;
                    MemToReg_l = 1'b0;
                    JAL_l = 1'b0;
                end
            6'b000011:      // JAL
                begin
                    RegWrite_l = 1'b1;
                    RegDest_l = 1'b1;
                    ALUSrc_l = 1'b0;
                    ALUOp_l = 2'b00;
                    Branch_eq_l = 1'b0;
                    Branch_ne_l = 1'b0;
                    MemWrite_l = 1'b0;
                    MemToReg_l = 1'b0;
                    JAL_l = 1'b1;
                end
        endcase
    end
    assign Branch_eq = Branch_eq_l;
    assign Branch_ne = Branch_ne_l;
    assign MemToReg = MemToReg_l;
    assign ALUSrc = ALUSrc_l;
    assign RegDest = RegDest_l;
    assign RegWrite = RegWrite_l;
    assign MemWrite = MemWrite_l;
    assign JAL = JAL_l;
    assign ALUOp = ALUOp_l;

endmodule