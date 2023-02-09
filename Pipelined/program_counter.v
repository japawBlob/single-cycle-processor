module program_counter(clk, reset, stall, pc_in, pc_out);
    input clk, reset, stall;
    input [31:0] pc_in;
    output [31:0] pc_out;

    wire clk, reset, pc_in;
    reg [31:0] pc_out;
    
    initial begin
        pc_out = 0;
    end


    always @(posedge clk) begin
        if (reset) 
            pc_out <= 32'h0;
        else if (~stall)
            pc_out <= pc_in;
        end
endmodule
