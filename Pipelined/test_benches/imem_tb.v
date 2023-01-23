module test_bench();
    reg clk = 0;
    reg reset = 0;
    always #5 clk = !clk;
    
    reg [7:0] a;
    wire [31:0] rd, blob, pc_in, pc_out;

    always #1 a = a+1;
    
    initial begin
        $dumpfile("for_wave.vcd");
        $dumpvars;

        
        #300 $finish;
    end

    imem imem_u (pc_out[9:2], rd);

    program_counter pc (clk, reset, pc_in, pc_out);

    adder add4 (pc_out, 32'h4, pc_in);

    always @(clk) $display( "Time: %d clk: %b\n", $time, clk);
    
endmodule
