//////////////////////////////////////////////////////
//
// Filename: test1.sv 
//
// Description:
//			Read transfer followed a write 
//			transfer at a random address.(Test item
//          1 on vPlan).
//
//////////////////////////////////////////////////////

module test1 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;
import ahb3lite_pkg::*;
logic [31:0] rdata;
logic [31:0] wdata;


	initial begin

		$timeformat (-9, 0, "ns", 9);

		$dumpvars;
		$dumpfile("dump.vcd");
		#4000ns $display("--------------MEMORY TEST TIMEOUT---------------");
		$finish;
	end

	initial begin
		$display("------------RUNNING TEST 1------------");
		intf.global_reset();
		wdata = 32'hDEADBEEF;
	
		intf.transfer(16'h8, wdata, HWRITE_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_SINGLE, HPROT_DATA,1);

        intf.transfer(16'h8, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_SINGLE, HPROT_DATA,1);

		if(wdata == rdata) $display("------------TEST PASSED---------------");
		 $finish;
	end

endmodule