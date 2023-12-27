
//////////////////////////////////////////////////////
//
// Filename: test10.sv 
//
// Description:
//			INCR8 implementation.
//
//////////////////////////////////////////////////////
module test10 (ahb_if intf);
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
		
		$display("------------RUNNING TEST 10------------");
		intf.global_reset();
		wdata = 8'hFF;

		for (int i = 0; i < 5; i++) begin
		addr = 16'h3C;
	
		intf.transfer(addr, wdata, HWRITE_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
		intf.transfer(addr + 1, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
	    intf.transfer(addr + 2, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
		intf.transfer(addr + 3, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
		intf.transfer(addr + 4, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
	
		intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
		if (!(rdata == wdata)) status++;
		intf.transfer(addr + 1, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8,HPROT_DATA, 1);
	    if (!(rdata == wdata)) status++;
		intf.transfer(addr + 2, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8, HPROT_DATA,1);
		if (!(rdata == wdata)) status++;
		intf.transfer(addr+3, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8,HPROT_DATA, 1);
		if (!(rdata == wdata)) status++;
	
		intf.transfer(addr + 4, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_INCR8,HPROT_DATA, 1);
		if (!(rdata == wdata)) status++;
		
		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");

		end
		 $finish;
	end

endmodule
