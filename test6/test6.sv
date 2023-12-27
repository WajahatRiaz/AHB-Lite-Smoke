module test6 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;

import ahb3lite_pkg::*;
logic [15:0] rdata;
logic [15:0] wdata;
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
		
		$display("------------RUNNING TEST 6------------");
		intf.global_reset();
		
		addr = $random;

		intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B16, HBURST_INCR,HPROT_DATA, 1);
		if (rdata != wdata) status++;
		
		intf.transfer(addr + 2, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B16, HBURST_INCR, HPROT_DATA,1);
	  	if (rdata != wdata) status++;

		

		intf.transfer(addr + 4, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B16, HBURST_INCR, HPROT_DATA,1);
	  	if (rdata == 32'hxxxxxxxx) status++;

		intf.transfer(addr + 6, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B16, HBURST_INCR, HPROT_DATA,1);
	  	if (rdata == 32'hxxxxxxxx) status++;

		

		if(status==0) $display("------------TEST PASSED---------------");
		else $display("------------TEST FAILED---------------");

	        #100 $finish;
	end

endmodule
