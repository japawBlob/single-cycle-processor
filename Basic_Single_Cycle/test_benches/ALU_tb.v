module test_bench();
    reg [31:0] SrcA, SrcB;    
    reg [2:0] ALUControl;      
    wire Zero; 
    wire [31:0] ALUResult; 
    reg clk = 0;
    
    ALU ALU_1(SrcA, SrcB, ALUControl, Zero, ALUResult);

    always #5 clk = !clk;
    always #10 ALUControl = ALUControl + 1;
    initial begin
        $dumpfile("for_wave.vcd");
        $dumpvars;

        SrcA = 32'hAA791D;
        SrcB = 32'h2347;
        ALUControl = 3'b0;

        #160 $finish;
    end
endmodule
