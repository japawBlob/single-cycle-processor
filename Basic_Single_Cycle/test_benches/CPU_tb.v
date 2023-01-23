module test_bench();
    reg clk = 0;
    reg reset = 1;
    always #5 clk = !clk;
    
    integer outfile, counter;

    initial begin
        $dumpfile("for_wave.vcd");
        $dumpvars;
        outfile = $fopen("debug.txt", "w");

        cpu_u.dmem_u.RAM[16] = 32'h5; // a
		cpu_u.dmem_u.RAM[20] = 32'h6; // b
		cpu_u.dmem_u.RAM[24] = 32'h3; // c

        #5 reset = 0;

        
        
        #300 $finish;
    end

    CPU cpu_u (clk, reset);

    

    always @ (posedge clk) begin
		if(counter == 50) // zastavi po 50 cyklech
			$stop;

		// print regs
		$fdisplay(outfile, "==============================================================");
		$fdisplay(outfile, "R0 = %d, R8  = %d, R16 = %d, R24 = %d", cpu_u.reg_file_u.register[0], cpu_u.reg_file_u.register[8] , cpu_u.reg_file_u.register[16], cpu_u.reg_file_u.register[24]);
		$fdisplay(outfile, "R1 = %d, R9  = %d, R17 = %d, R25 = %d", cpu_u.reg_file_u.register[1], cpu_u.reg_file_u.register[9] , cpu_u.reg_file_u.register[17], cpu_u.reg_file_u.register[25]);
		$fdisplay(outfile, "R2 = %d, R10 = %d, R18 = %d, R26 = %d", cpu_u.reg_file_u.register[2], cpu_u.reg_file_u.register[10], cpu_u.reg_file_u.register[18], cpu_u.reg_file_u.register[26]);
		$fdisplay(outfile, "R3 = %d, R11 = %d, R19 = %d, R27 = %d", cpu_u.reg_file_u.register[3], cpu_u.reg_file_u.register[11], cpu_u.reg_file_u.register[19], cpu_u.reg_file_u.register[27]);
		$fdisplay(outfile, "R4 = %d, R12 = %d, R20 = %d, R28 = %d", cpu_u.reg_file_u.register[4], cpu_u.reg_file_u.register[12], cpu_u.reg_file_u.register[20], cpu_u.reg_file_u.register[28]);
		$fdisplay(outfile, "R5 = %d, R13 = %d, R21 = %d, R29 = %d", cpu_u.reg_file_u.register[5], cpu_u.reg_file_u.register[13], cpu_u.reg_file_u.register[21], cpu_u.reg_file_u.register[29]);
		$fdisplay(outfile, "R6 = %d, R14 = %d, R22 = %d, R30 = %d", cpu_u.reg_file_u.register[6], cpu_u.reg_file_u.register[14], cpu_u.reg_file_u.register[22], cpu_u.reg_file_u.register[30]);
		$fdisplay(outfile, "R7 = %d, R15 = %d, R23 = %d, R31 = %d", cpu_u.reg_file_u.register[7], cpu_u.reg_file_u.register[15], cpu_u.reg_file_u.register[23], cpu_u.reg_file_u.register[31]);

		// print dmemory
		$fdisplay(outfile, "Data Memory: 0x00 =%d", {dmem_u.RAM[0]});
		$fdisplay(outfile, "Data Memory: 0x04 =%d", {dmem_u.RAM[1]});
		$fdisplay(outfile, "Data Memory: 0x08 =%d", {dmem_u.RAM[2]});
		$fdisplay(outfile, "Data Memory: 0x12 =%d", {dmem_u.RAM[3]});
		$fdisplay(outfile, "Data Memory: 0x16 =%d", {dmem_u.RAM[4]});
		$fdisplay(outfile, "Data Memory: 0x20 =%d", {dmem_u.RAM[5]});
		$fdisplay(outfile, "Data Memory: 0x24 =%d", {dmem_u.RAM[6]});
		$fdisplay(outfile, "Data Memory: 0x28 =%d", {dmem_u.RAM[7]});

		// print statuses
		$fdisplay(outfile, "==============================================================");
		$fdisplay(outfile, "PC = %d", cpu_u.program_counter_u.pc_out);
		// $fdisplay(outfile, "Next PC = %d (select %b, data0 = %d, data1 = %d)", cpu_u.mux_pc.data_out, CPU.mux_pc.select, CPU.mux_pc.data0_in, CPU.mux_pc.data1_in);
		//$fdisplay(outfile, "Control unit: RegWrite = %b; RegAddress = %b, Data = %d", cpu_u.reg_file_u.RegWrite, cpu_u.reg_file_u.Rd_addr, cpu_u.reg_file_u.Rd_data);
		// $fdisplay(outfile, "ALU: RegWrite = %b; RegAddress = %b, Data = %d", cpu_u.reg_file_u.RegWrite, cpu_u.reg_file_u.Rd_addr, cpu_u.reg_file_u.Rd_data);

		// print instruction
		$fdisplay(outfile, "Instruction = %b", cpu_u.instruction);

		$fdisplay(outfile, "\n");

		counter = counter + 1;
	end

    always @(clk) $display( "Time: %d clk: %b", $time, clk);
    
endmodule
