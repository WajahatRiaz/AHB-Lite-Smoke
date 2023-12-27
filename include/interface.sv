interface ahb_if #(
    parameter MEM_SIZE          = 32,
    parameter MEM_DEPTH         = 256,
    parameter HADDR_SIZE        = 16,
    parameter HDATA_SIZE        = 32)
    (input bit HRESETn, input bit HCLK);

timeunit 1ns;
timeprecision 1ns;

    logic                      HSEL;
    logic     [HADDR_SIZE-1:0] HADDR;
    logic     [HDATA_SIZE-1:0] HWDATA;
    logic     [HDATA_SIZE-1:0] HRDATA;
    logic                      HWRITE;
    logic     [2:0]            HSIZE;
    logic     [2:0]            HBURST;
    logic     [3:0]            HPROT;
    logic     [1:0]            HTRANS;
    logic                      HREADYOUT;
    logic                      HREADY;
    logic                      HRESP;

    modport tb(
        // slave to master, dut to testbench
        input HRESETn, HREADY, HRESP, HCLK, HRDATA,
        // master to slave  
        output HADDR, HWRITE, HSIZE, HBURST, HPROT, HTRANS, HWDATA, HSEL,
        import global_reset, transfer);
  
    task global_reset();

        wait(!HRESETn); 
        HSEL<= 1'b1;
        HPROT <= 4'b0; 
        HADDR <= 32'h0;
        HTRANS <= 2'b0;
        HBURST <= 3'b0;
        HSIZE <= 3'b0;
        HWRITE <=1'b0;
        HWDATA <= 32'h0;
        HREADY <=  1;
        wait(HRESETn);
        
        $display("--------------------------------------");        
        $display("|           System Reset             |");
        $display("--------------------------------------");        

    endtask
  
    task transfer(input logic [HADDR_SIZE-1:0] addr, 
			inout logic [HDATA_SIZE-1:0] data,
			input logic hwrite, 
            input logic [1:0] htrans,
            input logic [2:0] hsize,
			input logic [2:0] hburst, 
            input logic [3:0] hprot,
			input bit debug);
    
	if (HRESP == 0 && HREADY ==0) begin 

		$display("--------------------------------------");        
       		$display("|           Transfer Pending         |");
        	$display("--------------------------------------");  
		wait(HREADY);      
	end

        if (HRESP ==0 && HREADY==1) begin

            @(negedge HCLK); // 1st clock
    
            HPROT  <= hprot; // hardwiring to a value
            HADDR  <= addr;
            HTRANS <= htrans;
            HBURST <= hburst; 
            HSIZE  <=  hsize ;
            HWRITE <= hwrite;
	    
            @(negedge HCLK); //2nd clock

            if (!HREADYOUT) begin
                wait(HREADYOUT);    
                if (hwrite == 1) begin 
                    @(negedge HCLK);
                    HWDATA <= data;
                end
                else begin 
                    @(negedge HCLK);
                    data = HRDATA;
                end
             end

           else begin 

                if (hwrite == 1) begin 
                   
                    HWDATA <= data;
                end
                else begin 
                    
                    data = HRDATA;
                end
           end



            if (debug == 1) begin
                
                  $display("--------------------------------------");  
                  if (hwrite == 1) $display("|  WRITING addr:%h data:%h   |", addr, data);
                  else $display("|  READING addr:%h data:%h   |", addr, data);
                  $display("--------------------------------------");        
            end
        end

        else if (HRESP != 0) $display("ERROR Response from slave");      

    endtask


 endinterface