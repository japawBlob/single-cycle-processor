module alu_decoder (Funct, ALUOp, ALUControl, JR, shift);
    input [5:0] Funct;
    input [1:0] ALUOp;
    output reg [2:0] ALUControl; 

    output JR;
    output shift;

    always @(*) begin
        case(ALUOp) 
            2'b00: ALUControl = 3'b010; // ADDI, LW, SW
            2'b01: ALUControl = 3'b110; // BNE, BEQ
        default:
            case(Funct) // 10 for R opperations
                6'b100000: ALUControl = 3'b010; // ADD
                6'b100010: ALUControl = 3'b110; // SUB
                6'b100100: ALUControl = 3'b000; // bitwise-AND
                6'b100101: ALUControl = 3'b001; // bitwise-OR
                6'b101010: ALUControl = 3'b111; // SLT
                6'b000000: ALUControl = 3'b100; // SLL
                6'b000010: ALUControl = 3'b101; // SLR
            default:
                ALUControl = 3'b000;
            endcase
        endcase
    end

    assign JR = ( {ALUOp,Funct} == 8'b10001000 ) ? 1 : 0; 
    assign shift = (Funct == 6'b000000) ? 1 : (Funct == 6'b000010) ? 1 : 0;
    // assign JR = (ALUOp == 2'b10) ? ( (funct == 6'b001000) ? 1 : 0 ) : 0;


endmodule