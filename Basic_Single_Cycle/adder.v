module adder ( data0, data1, data_out );
        input [31:0] data0, data1;
        output reg [31:0] data_out;

        always @(data0, data1) 
        begin
            data_out = data0 + data1;
        end
endmodule