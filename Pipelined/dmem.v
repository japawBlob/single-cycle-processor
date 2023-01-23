module dmem (input clk, we,
             input [31:0] a, wd,
             output [31:0] rd);

    reg [31:0] RAM [127:0];

    assign rd = RAM[a[7:2]]; // word aligned

    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1 ) begin
            RAM[i] = 32'b0;    // All registers should be initialised to zero by verilog. This is just to be safe
        end
    end

    always@(posedge clk)
        if(we) RAM[a[31:2]] <= wd;

endmodule
