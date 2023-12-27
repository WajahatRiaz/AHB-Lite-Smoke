//////////////////////////////////////////////////////
//
// Filename: test3.sv 
//
// Description:
//			Performing a read or write transfer given
//          that slave is not selected during 
//          transactions. (Test item 3 on vPlan).
//
//////////////////////////////////////////////////////
module test3 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;

import ahb3lite_pkg::*;
logic [7:0] rdata;
logic [7:0] wdata;
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
		
		$display("------------RUNNING TEST 3------------");
		intf.global_reset();
		
		intf.HSEL <= 2;
		
		for (int i =0; i< 10; i++)begin
			wdata = $random;
			addr = $random;
	
			intf.transfer(addr, wdata, HWRITE_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_SINGLE, HPROT_DATA,1);
		
			intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_SINGLE, HPROT_DATA,1);

		    if (rdata == wdata) status++;
		end
		
		if (status != 0)$display("------------TEST FAILED---------------");
		else $display("------------TEST PASSED---------------");
	
		$finish;
	end

endmodule

