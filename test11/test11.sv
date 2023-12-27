//////////////////////////////////////////////////////
//
// Filename: test11.sv 
//
// Description:
//			WRAP4 implementation.
//
//////////////////////////////////////////////////////
module test11 (ahb_if intf);
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
		
		$display("------------RUNNING TEST 11------------");
		intf.global_reset();
		wdata = 8'hFF;

		for (int i = 0; i < 5; i++) begin
		addr = 16'h3C;
	
		intf.transfer(addr, wdata, HWRITE_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
		intf.transfer(addr + 1, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
	    intf.transfer(addr + 2, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
		intf.transfer(16'h30, wdata, HWRITE_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
	
		intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
		if (!(rdata == wdata)) status++;
		intf.transfer(addr + 1, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4,HPROT_DATA, 1);
	    if (!(rdata == wdata)) status++;
		intf.transfer(addr + 2, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4, HPROT_DATA,1);
		if (!(rdata == wdata)) status++;
		intf.transfer(16'h30, rdata, HREAD_OP , HTRANS_SEQ, HSIZE_B8, HBURST_WRAP4,HPROT_DATA, 1);
		if (!(rdata == wdata)) status++;
		
		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");

		end
		$finish;
	end

endmodule
