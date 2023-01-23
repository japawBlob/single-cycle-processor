module reg_file ( A1, A2, A3, WD3, WE3, clk, RD1, RD2 );
    input [4:0] A1, A2;    // Register adress where the data is supposed to be read
    input [4:0] A3;        // Register adress where the data is supposed to be written
    input [31:0] WD3;      // Write data - corresponding to the A3 adress;
    input WE3;             // Only write WD3 to adress A3 if Write_Enable_3 aka WE3 is active
    input clk;
    output [31:0] RD1, RD2; // Data read from adresses A1 and A2 respectively

    reg [31:0] register [31:0]; // Registers for storing the data. 
    
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1 ) begin
            register[i] = 32'b0;    // All registers should be initialised to zero by verilog. This is just to be safe
        end
    end

    assign RD1 = register[A1];
    assign RD2 = register[A2];
    
    always @(posedge clk) begin
        if (WE3 && A3) begin  // Don't write if adress A3 is 0 -> zero register is supposed to remain 0;
            register[A3] = WD3;
        end
    end

endmodule
