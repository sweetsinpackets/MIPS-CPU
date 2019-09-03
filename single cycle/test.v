`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 21:26:13
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test;

	integer i = -1;

	// Inputs
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	single_cycle uut (clk	);

	
	initial begin
            // Initialize Inputs
            clk = 0;
            $dumpvars(1, uut);
            $display("Texual result of single cycle:");
            $display("==========================================================");
            #500;
            $stop;
        end
	
	always #10 begin
	    
        $display("Time: %d, CLK = %d, PC = 0x%H", i, clk, uut.pc_out);     
		$display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.Register.regs[16], uut.Register.regs[17], uut.Register.regs[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.Register.regs[19], uut.Register.regs[20], uut.Register.regs[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.Register.regs[22], uut.Register.regs[23], uut.Register.regs[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.Register.regs[9], uut.Register.regs[10], uut.Register.regs[11]);
	    $display("----------------------------------------------------------");
       clk = ~clk;
       if (clk) i = i + 1;
    end
endmodule
