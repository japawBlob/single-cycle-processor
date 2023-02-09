module jump_resolve (Zero, JAL, JR, Branch_ne, Branch_eq,
                     PCSrc);
    input Zero, JAL, JR, Branch_eq, Branch_ne;
    output PCSrc;

    wire Branch_eq, Branch_ne, JAL, JR, Zero, PCSrc;

    assign PCSrc = Zero & Branch_eq | ~Zero & Branch_ne | JAL | JR;
endmodule