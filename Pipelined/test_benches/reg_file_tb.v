module test_bench();
    reg [4:0] A1, A2;    
    reg [4:0] A3;        
    reg [31:0] WD3;      
    reg WE3 = 0; 
    wire [31:0] RD1, RD2; 
    reg clk = 0;

    reg_file reg_file_1(A1, A2, A3, WD3, WE3, clk, RD1, RD2);
    
    always #5 clk = !clk;
    initial begin
        WD3 = 32'b1101;
        A3 = 5'b11;
        $dumpfile("for_wave.vcd");
        $dumpvars;
        #10 WE3 = !WE3;
        #20 WE3 = !WE3;

        #30 A1 = 5'b11;
        A2 = 5'd20;
        #10
        WD3 = 32'hAA791D;
        A3 = 5'd11;
        WE3 = 1;
        #10 WE3 = 0;
        A2 = 5'd11;

        A1 = 5'd0;      // test writing to zero register
        #5 A3 = 5'd0;
        WE3 = 1;
        
        // $display("%x\n", reg_file_1.register[11]);

        #160 $finish;
    end
    
endmodule
