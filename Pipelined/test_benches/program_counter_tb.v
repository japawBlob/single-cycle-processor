module test_bench();
    reg reset;
    
    reg [31:0] pc_in;
    wire [31:0] pc_out;

    reg clk = 0;
    always #5 clk = !clk;
    always #12 pc_in = pc_in + 4;
    
    initial begin
        reset = 1;
        pc_in = 32'h0;
        $dumpfile("test.vcd");
        $dumpvars;
        #7 reset = ~reset;
        #160 $finish;
    end

    

    program_counter pc_1(clk, reset, pc_in, pc_out);

    always #90 reset = ~reset;
    always #100 reset = ~reset;

    always @(clk) $display( "Time: %d Program counter %d, clk: %b, reset %b\n", $time, pc_out, clk, reset);
    
endmodule
