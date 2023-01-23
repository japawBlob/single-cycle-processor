module ALU(SrcA, SrcB, ALUControl, Zero, ALUResult);
    input wire [31:0] SrcA, SrcB;
    input wire [2:0] ALUControl;
    output wire Zero;
    output wire [31:0] ALUResult;

    reg [31:0] out;

    always @ (*)
    case (ALUControl)
        3'b010: out = SrcA + SrcB;
        3'b110: out = SrcA - SrcB;
        3'b000: out = SrcA & SrcB;
        3'b001: out = SrcA | SrcB;
        3'b011: out = SrcA ^ SrcB;
        3'b111: out = (SrcA < SrcB) ? 1 : 0;
        3'b100: out = SrcB << SrcA;
        3'b101: out = SrcB >> SrcA;
        default: out = 0;
    endcase

    assign ALUResult = out;
    assign Zero = (out) ? 0 : 1;

endmodule
