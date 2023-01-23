module test_bench();
    reg clk = 0;
    always #5 clk = !clk;

    wire [5:0] Opcode;
    wire [5:0] Funct;

    reg [5:0] Opcode_l;
    reg [5:0] Funct_l;
    wire Zero;
    wire MemToReg, MemWrite, ALUSrc, RegDest, RegWrite, PCSrc, JAL, JR;
    wire [2:0] ALUControl;

    assign Opcode = Opcode_l;
    assign Funct = Funct_l;

    wire [31:0] SignImm;
    wire [31:0] SrcA;
    wire [31:0] SrcB;
    wire [15:0] imm_instrt;
    reg [15:0] imm_instrt_t;

    wire [31:0] RD1;
    reg [31:0] RD1_t;
    wire [31:0] RD2;
    reg [31:0] RD2_t;
    wire [31:0] AluOut;

    assign imm_instrt = imm_instrt_t;
    assign RD2 = RD2_t;
    assign RD1 = RD1_t;
    
    initial begin
        $dumpfile("for_wave.vcd");
        $dumpvars;
        imm_instrt_t = 15'h10;
        RD1_t = 31'h10;
        RD2_t = 31'h20;
        #10
        Opcode_l = 6'b000000;   //ADD
        Funct_l = 6'b100000;
        #10
        Funct_l = 6'b100100;    //AND
        #10
        Funct_l = 6'b100101;    //OR
        #10
        Funct_l = 6'b101010;    //STL
        #10
        Funct_l = 6'b000000;    //SLL
        #10
        Funct_l = 6'b000010;    //SLR
        #10
        Funct_l = 6'b100010;    //SUB
        #10
        Funct_l = 6'b001000;    //JR
        #10 
        Opcode_l = 6'b001000;   //ADDI
        #10 
        Opcode_l = 6'b000100;   //BEQ
        #10 
        Opcode_l = 6'b000101;   //BNE
        #10 
        Opcode_l = 6'b100011;   //LW
        #10 
        Opcode_l = 6'b101011;   //SW
        #10 
        Opcode_l = 6'b000011;   //JAL
        #160 $finish;
    end

    control_unit con_u(Opcode, Funct, Zero, MemToReg, MemWrite, ALUControl, ALUSrc, RegDest, RegWrite, PCSrc, JAL, JR);

    mux_2_1 ALU_SrcB (RD2, SignImm, ALUSrc, SrcB);

    sign_ext sign_ext_u (imm_instrt, SignImm);

    ALU ALU_u (RD1, SrcB, ALUControl, Zero, AluOut);

    always @(clk) $display( "Time: %d clk: %b\n", $time, clk);
    
endmodule
