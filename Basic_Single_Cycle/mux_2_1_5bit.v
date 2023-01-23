module mux_2_1_5bit(d0,  d1, select, y);
    input [4:0] d0, d1;
    input select;
    output [4:0] y;

    // always @(select) 
    // begin
    //   if (select) 
    //     y <= d1;
    //   else
    //     y <= d0;
    // end
    assign y = (select) ? d1 : d0;

endmodule