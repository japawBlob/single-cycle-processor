module IF_ID(clk, reset,  PC_4_in, instr_in, flush, stall,
            PC_4_out, instr_out);
input clk, reset, stall, flush;
input [31:0] PC_4_in, instr_in;
output [31:0] PC_4_out, instr_out;

reg [31:0] PC_4_out, instr_out;

always @(posedge clk) begin 
    if (reset) begin
        PC_4_out <= 32'b0;
        instr_out <= 32'b0;
    end
    else begin
        if (stall) begin
			PC_4_out <= PC_4_out;
			instr_out <= instr_out;
		end
		else begin
			if (flush) begin
				PC_4_out <= 32'b0;
				instr_out <= 32'b0;
			end
			else begin
				PC_4_out <= PC_4_in;
				instr_out <= instr_in;
			end
		end
    end
end

endmodule