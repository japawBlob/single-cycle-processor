module mux_2_1(d0,  d1, select, y);
    input [31:0] d0, d1;
    input select;
    output [31:0] y;

    // always @(select) 
    // begin
    //   if (select) 
    //     y <= d1;
    //   else
    //     y <= d0;
    // end
    assign y = (select) ? d1 : d0;

endmodule