module MEM_WB(clk, reset, 
              RegWrite_MEM, MemToReg_MEM, execution_out_MEM, ReadData_MEM, WriteReg_MEM,
              RegWrite_WB, MemToReg_WB, execution_out_WB, ReadData_WB, WriteReg_WB);

input clk, reset, RegWrite_MEM, MemToReg_MEM; 
input [31:0] execution_out_MEM, ReadData_MEM;
input [4:0] WriteReg_MEM;

output RegWrite_WB, MemToReg_WB; 
output [31:0] execution_out_WB, ReadData_WB;
output [4:0] WriteReg_WB;

reg RegWrite_WB, MemToReg_WB; 
reg [31:0] execution_out_WB, ReadData_WB;
reg [4:0] WriteReg_WB;

always @(posedge clk) begin
    if (reset) begin
        RegWrite_WB <= 1'b0;
        MemToReg_WB <= 1'b0;
        execution_out_WB <= 32'b0;
        ReadData_WB <= 32'b0;
        WriteReg_WB <= 5'b0;
    end
    else begin
        RegWrite_WB <= RegWrite_MEM;
        MemToReg_WB <= MemToReg_MEM;
        execution_out_WB <= execution_out_MEM;
        ReadData_WB <= ReadData_MEM;
        WriteReg_WB <= WriteReg_MEM;
    end
end

endmodule