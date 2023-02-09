module EXE_MEM(clk, reset,
               RegWrite_EX, MemToReg_EX, MemWrite_EX, AluOut_EX, WriteReg_EX, RtD_EX, PCPlus4_EX, JAL_EX,
               RegWrite_MEM, MemToReg_MEM, MemWrite_MEM, AluOut_MEM, WriteReg_MEM, RtD_MEM, PCPlus4_MEM, JAL_MEM);
    input clk, reset, RegWrite_EX, MemToReg_EX, MemWrite_EX, JAL_EX;
    input [31:0] AluOut_EX, RtD_EX, PCPlus4_EX;
    input [4:0]  WriteReg_EX;

    output RegWrite_MEM, MemToReg_MEM, MemWrite_MEM, JAL_MEM;
    output [31:0] AluOut_MEM, RtD_MEM, PCPlus4_MEM;
    output [4:0] WriteReg_MEM;

    reg RegWrite_MEM, MemToReg_MEM, MemWrite_MEM, JAL_MEM;
    reg [31:0] AluOut_MEM, RtD_MEM, PCPlus4_MEM;
    reg [4:0] WriteReg_MEM;

    always @(posedge clk) begin
        if (reset) begin
            RegWrite_MEM <= 1'b0; 
            MemToReg_MEM <= 1'b0;
            MemWrite_MEM <= 1'b0;
            AluOut_MEM <= 32'b0;
            RtD_MEM <= 32'b0;
            WriteReg_MEM <= 5'b0;
            JAL_MEM <= 1'b0;
            PCPlus4_MEM <= 1'b0;
        end
        else begin
            RegWrite_MEM <= RegWrite_EX; 
            MemToReg_MEM <= MemToReg_EX;
            MemWrite_MEM <= MemWrite_EX;
            AluOut_MEM <= AluOut_EX;
            RtD_MEM <= RtD_EX;
            WriteReg_MEM <= WriteReg_EX;
            JAL_MEM <= JAL_EX;
            PCPlus4_MEM <= PCPlus4_EX;
        end
    end

endmodule