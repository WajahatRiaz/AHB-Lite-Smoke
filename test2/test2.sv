//////////////////////////////////////////////////////
//
// Filename: test2.sv 
//
// Description:
//			Before continuous read transfers, 
//          an HRESTn is driven low asynchronously. 
//          (Test item 2 on vPlan).
//
//////////////////////////////////////////////////////

module test2 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;

import ahb3lite_pkg::*;
logic [31:0] rdata;
logic [31:0] wdata;
logic [15:0] addr;
int status;


	initial begin

		$timeformat (-9, 0, "ns", 9);

		$dumpvars;
		$dumpfile("dump.vcd");
		#4000ns $display("--------------MEMORY TEST TIMEOUT---------------");
		$finish;
	end

	initial begin
		
		$display("------------RUNNING TEST 2------------");
		intf.global_reset();
		for (int i =0 ; i < 20; i++) begin
			addr = $random;
		
			intf.transfer(addr + 4, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_INCR, HPROT_DATA,1);
	  		if (rdata != 32'hxxxxxxxx) status++;
		end
		
		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");

	    $finish;
	end

endmodule
