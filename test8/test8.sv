//////////////////////////////////////////////////////
//
// Filename: test8.sv 
//
// Description:
//			HPROT signal implementation.
//
//////////////////////////////////////////////////////
module test8 (ahb_if intf);
timeunit 1ns;
timeprecision 1ns;

import ahb3lite_pkg::*;
logic [7:0] rdata;
logic [7:0] wdata;
logic [15:0] addr;
bit [3:0] hprot;

int status;

	initial begin

		$timeformat (-9, 0, "ns", 9);

		$dumpvars;
		$dumpfile("dump.vcd");
		#4000ns $display("--------------MEMORY TEST TIMEOUT---------------");
		$finish;
	end


	initial begin
		
		$display("------------RUNNING TEST 8------------");
		intf.global_reset();
		for (int i =0; i < 16; i++) begin
			addr = $random;
			hprot = $random;

			wdata = 8'hFF;		
			intf.transfer(addr, wdata, HWRITE_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_SINGLE, hprot,1);
	
			intf.transfer(addr, rdata, HREAD_OP , HTRANS_NONSEQ, HSIZE_B8, HBURST_SINGLE, hprot,1);
			if (rdata!=8'hFF) status ++;
		
		end

			if(status==0) $display("------------TEST PASSED---------------");
			else $display("------------TEST FAILED---------------");

		$finish;
	end
endmodule
