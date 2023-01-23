module sign_ext (input [15:0] d0,
        output [31:0]  out
        );  
    assign out = { {16{d0[15]}}, d0[15:0]};
endmodule