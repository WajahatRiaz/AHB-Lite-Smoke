
module testbench
#(
  parameter MEM_SIZE          = 32,
  parameter MEM_DEPTH         = 256,
  parameter HADDR_SIZE        = 16,
  parameter HDATA_SIZE        = 32
);

timeunit 1ns;
timeprecision 1ns;

 //global value
  bit HCLK;
  bit HRESETn;
  
  // Clock generation  
  always #5 HCLK = ~ HCLK;
  
  initial begin 
	   HRESETn = 0;    // reset everythin ACTIVE LOW
	   #2 HRESETn = 1;   // Continue
  end  


  // interface instantiation
  ahb_if #(.MEM_SIZE(MEM_SIZE), 
		.MEM_DEPTH(MEM_DEPTH),
		.HADDR_SIZE(HADDR_SIZE),
		.HDATA_SIZE(HDATA_SIZE))
		intf (HRESETn, HCLK);

  `ifdef TEST1
   test1 t1(intf.tb);
  `endif

  `ifdef TEST2
   test2 t2(intf.tb); 
  `endif
  
  `ifdef TEST3
   test3 t3(intf.tb); 
  `endif
  
  `ifdef TEST4
   test4 t4(intf.tb); 
  `endif
  
  `ifdef TEST5
   test5 t5(intf.tb); 
  `endif

  `ifdef TEST6
   test6 t6(intf.tb); 
  `endif

  `ifdef TEST7
   test7 t7(intf.tb); 
  `endif

  `ifdef TEST8
   test8 t8(intf.tb); 
  `endif

  `ifdef TEST9
   test9 t9(intf.tb); 
  `endif

  `ifdef TEST10
   test10 t10(intf.tb); 
  `endif

  `ifdef TEST11
   test11 t11(intf.tb); 
  `endif

`ifdef TEST12
   test12 t12(intf.tb); 
  `endif

  
  // DUT instantiation
  
  ahb3liten dut (
    .HCLK(intf.HCLK),
    .HRESETn(intf.HRESETn),
    .HSEL(intf.HSEL),
    .HADDR(intf.HADDR),
    .HWDATA(intf.HWDATA),
    .HRDATA(intf.HRDATA),
    .HWRITE(intf.HWRITE),
    .HSIZE(intf.HSIZE),
    .HBURST(intf.HBURST),
    .HPROT(intf.HPROT),
    .HTRANS(intf.HTRANS),
    .HREADYOUT(intf.HREADYOUT),
    .HREADY(intf.HREADY),
    .HRESP(intf.HRESP) 
  );

 bind ahb3liten coverage_module cov_harness(.*);
 //bind ahb3liten assertion_module assert_harness(.*);


//`define EOF_TESTBENC
  
endmodule
