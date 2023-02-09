module mut_3_1(d0, d1, d2, select, y);
    input [31:0] d0, d1, d2;
    input [1:0] select;
    output [31:0] y;

    wire [31:0] d0, d1;
    wire select;
    reg [31:0] y;

    always @(select) 
    begin
      case (select) 
        0 : y <= d0;
        1 : y <= d1;
        2 : y <= d2;
        default : y <= 32'hAA791D;
      endcase
    end

endmodule