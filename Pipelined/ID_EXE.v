module ID_EXE(clk, reset, stall,
              MemToReg_in, MemWrite_in, ALUControl_in, ALUSrc_in, RegDest_in, RegWrite_in, JAL, shift_in, shift_ammount_ID,
              Rs_data_in, Rt_data_in, Rs_addr_in, Rt_addr_in, Rd_addr_in, imm_in, PCPlus4_ID,
              MemToReg_out, MemWrite_out, ALUControl_out, ALUSrc_out, RegDest_out, RegWrite_out, JAL_EX, shift_out, shitf_ammount_EX,
              Rs_data_out, Rt_data_out, Rs_addr_out, Rt_addr_out, Rd_addr_out, imm_out, PCPlus4_EX );
    
    input clk, reset, stall, MemToReg_in, MemWrite_in, ALUSrc_in, RegDest_in, RegWrite_in, JAL, shift_in;
    input [2:0] ALUControl_in;
    input [31:0] Rs_data_in, Rt_data_in, imm_in, PCPlus4_ID;
    input [4:0] Rs_addr_in, Rt_addr_in, Rd_addr_in, shift_ammount_ID;

    output MemToReg_out, MemWrite_out, ALUSrc_out, RegDest_out, RegWrite_out, shift_out, JAL_EX;
    output [2:0] ALUControl_out;
    output [31:0] Rs_data_out, Rt_data_out, imm_out, PCPlus4_EX;
    output [4:0] Rs_addr_out, Rt_addr_out, Rd_addr_out, shitf_ammount_EX;

    reg MemToReg_out, MemWrite_out, ALUSrc_out, RegDest_out, RegWrite_out, shift_out, JAL_EX;
    reg [2:0] ALUControl_out;
    reg [31:0] Rs_data_out, Rt_data_out, imm_out, PCPlus4_EX;
    reg [4:0] Rs_addr_out, Rt_addr_out, Rd_addr_out, shitf_ammount_EX;

    always @(posedge clk) begin
        if (reset) begin
            MemToReg_out <= 1'b0;
            MemWrite_out <= 1'b0;
            ALUSrc_out <= 1'b0;
            RegDest_out <= 1'b0;
            RegWrite_out <= 1'b0;
            shift_out <= 1'b0;
            ALUControl_out <= 3'b0;
            Rs_data_out <= 32'b0;
            Rt_data_out <= 32'b0;
            imm_out <= 32'b0;
            Rs_addr_out <= 5'b0;
            Rt_addr_out <= 5'b0;
            Rd_addr_out <= 5'b0;
            PCPlus4_EX <= 32'b0;
            shitf_ammount_EX <= 5'b0;
            JAL_EX <= 1'b0;
        end
        else if (stall) begin
            MemToReg_out <= MemToReg_out;
            MemWrite_out <= MemWrite_out;
            ALUSrc_out <= ALUSrc_out;
            RegDest_out <= RegDest_out;
            RegWrite_out <= RegWrite_out;
            shift_out <= shift_out;
            ALUControl_out <= ALUControl_out;
            Rs_data_out <= Rs_data_out;
            Rt_data_out <= Rt_data_out;
            imm_out <= imm_out;
            Rs_addr_out <= Rs_addr_out;
            Rt_addr_out <= Rt_addr_out;
            Rd_addr_out <= Rd_addr_out;
            PCPlus4_EX <= PCPlus4_EX;
            shitf_ammount_EX <= shitf_ammount_EX;
            JAL_EX <= JAL_EX;
        end
        else begin
            MemToReg_out <= MemToReg_in;
            MemWrite_out <= MemWrite_in;
            ALUSrc_out <= ALUSrc_in;
            RegDest_out <= RegDest_in;
            RegWrite_out <= RegWrite_in;
            shift_out <= shift_in;
            ALUControl_out <= ALUControl_in;
            Rs_data_out <= Rs_data_in;
            Rt_data_out <= Rt_data_in;
            imm_out <= imm_in;
            Rs_addr_out <= Rs_addr_in;
            Rt_addr_out <= Rt_addr_in;
            Rd_addr_out <= (JAL) ? 5'b11111 : Rd_addr_in;
            PCPlus4_EX <= PCPlus4_ID;
            shitf_ammount_EX <= shift_ammount_ID;
            JAL_EX <= JAL;
        end
    end


endmodule