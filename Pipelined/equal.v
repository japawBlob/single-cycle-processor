module equal(d0, d1, 
             out);

input [31:0] d0, d1;
output out;

assign out = (d0 == d1) ? 1 : 0 ;

endmodule