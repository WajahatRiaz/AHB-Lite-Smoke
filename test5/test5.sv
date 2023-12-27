//////////////////////////////////////////////////////
//
// Filename: test5.sv 
//
// Description:
//			Some IDLE transfers are made which to 
//          ensure no data transfers are made.
//          (Test item 5 on vPlan).
//
//////////////////////////////////////////////////////
module test5 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;

import ahb3lite_pkg::*;
logic [7:0] rdata;
logic [7:0] wdata[4];
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
		
		$display("------------RUNNING TEST 5------------");
		intf.global_reset();
		wdata[0] =8'hDE;
		wdata[1] =8'hAD;
		wdata[2] =8'hBE;
		wdata[3] =8'hEF;

		addr = 16'h20;

		

		
			intf.transfer(addr, wdata[0], HWRITE_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_INCR, HPROT_DATA,1);

			intf.transfer(addr + 1, wdata[1], HWRITE_OP , HTRANS_BUSY, HSIZE_B8, HBURST_INCR, HPROT_DATA,1);

	    	intf.transfer(addr + 2, wdata[2], HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR, HPROT_DATA,1);
			intf.transfer(addr+ 3, wdata[3], HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR,HPROT_DATA, 1);
	
			intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_INCR, HPROT_DATA,1);
			if (rdata != 8'hDE) status++;

			intf.transfer(addr + 1, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR,HPROT_DATA, 1);
	    	if (rdata != 8'hDE) status++;

			intf.transfer(addr + 2, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR,HPROT_DATA, 1);
			if (rdata != 8'hAD) status++;
			intf.transfer(addr +3, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR, HPROT_DATA,1);
			if (rdata != 8'hBE) status++;


		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");
		
		$finish;
	end

endmodule
