module test7 (ahb_if intf);
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
		
		$display("------------RUNNING TEST 7-----------");
		intf.global_reset();
		wdata = 32'hABBABBA;
		addr = 16'h20;
			
		intf.transfer(addr, wdata, HWRITE_OP , HTRANS_IDLE, HSIZE_B32, HBURST_WRAP4, HPROT_DATA, 1);
		intf.transfer(addr + 4, wdata, HWRITE_OP , HTRANS_IDLE, HSIZE_B32, HBURST_WRAP4, HPROT_DATA, 1);
		intf.transfer(addr + 8, wdata, HWRITE_OP , HTRANS_IDLE, HSIZE_B32, HBURST_WRAP4, HPROT_DATA, 1);
		intf.transfer(addr + 12, wdata, HWRITE_OP , HTRANS_IDLE, HSIZE_B32, HBURST_WRAP4, HPROT_DATA, 1);
		
	
		intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_WRAP4, HPROT_DATA,1);
		if (rdata == wdata) status++;
	
		intf.transfer(addr + 4, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_WRAP4, HPROT_DATA,1);

		if (rdata == wdata + 8) status++;

		intf.transfer(addr+ 12, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B32, HBURST_WRAP4, HPROT_DATA,1);
		if (rdata == wdata) status++;
				


		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");

		$finish;
	end

endmodule
