
module coverage_module#(
  parameter MEM_SIZE          = 32,
  parameter MEM_DEPTH         = 256,
  parameter HADDR_SIZE        = 16,
  parameter HDATA_SIZE        = 32
)
( 
  input                       HRESETn,
                              HCLK,
  input                       HSEL,
  input      [HADDR_SIZE-1:0] HADDR,
  input      [HDATA_SIZE-1:0] HWDATA,
  output reg [HDATA_SIZE-1:0] HRDATA,
  input                       HWRITE,
  input      [           2:0] HSIZE,
  input      [           2:0] HBURST,
  input      [           3:0] HPROT,
  input      [           1:0] HTRANS,
  output reg                  HREADYOUT,
  input                       HREADY,
  output                      HRESP
);

timeunit 1ns;
timeprecision 1ns;


  covergroup cg_check @(posedge HCLK);
    option.per_instance = 1;
    write_transfer: coverpoint HWRITE { bins writes = {1};  }
    read_transfer: coverpoint HWRITE { bins writes = {0};  }

  endgroup

// Covergroup for HSIZE coverage
covergroup cg_hsize @(posedge HCLK); 
    option.per_instance = 1;

    HSIZE_COVER: coverpoint HSIZE {
        bins b0 = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111};
    }
endgroup

// Covergroup for HBURST coverage
covergroup cg_hburst @(posedge HCLK); 
    option.per_instance = 1;

    HBURST_COVER: coverpoint HBURST {
        bins b0 = {3'b000, 3'b001, 3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111};
    }
endgroup

// Covergroup for HPROT coverage
covergroup cg_hprot @(posedge HCLK); 
    option.per_instance = 1;

    HPROT_COVER: coverpoint HPROT {
        bins b0 = {4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110, 4'b0111,
                   4'b1000, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111};
    }
endgroup

// Covergroup for HTRANS coverage
covergroup cg_htrans @(posedge HCLK); 
    option.per_instance = 1;

    HTRANS_COVER: coverpoint HTRANS {
        bins b0 = {2'b00, 2'b01, 2'b10, 2'b11};
    }
endgroup

// Covergroup for HRESP coverage
covergroup cg_hresp @(posedge HCLK); 
    option.per_instance = 1;

    HRESP_COVER: coverpoint HRESP {
        bins b0 = {2'b00, 2'b01, 2'b10};
    }
endgroup

// Covergroup for HSEL being asserted during valid transactions
covergroup cg_hsel_valid @(posedge HCLK); 
    option.per_instance = 1;

    HSEL_VALID_COVER: coverpoint {HSEL, HREADY} iff (HREADYOUT == 1) {
        bins valid_transaction = (1, 1);
    }
endgroup

// Covergroup for HRDATA being stable during valid transactions
covergroup cg_hrdata_stable @(posedge HCLK); 
    option.per_instance = 1;

    HRDATA_STABLE_COVER: coverpoint {HREADYOUT, $stable(HRDATA)} iff (HREADYOUT == 1) {
        bins stable_hrdata = (1, 1);
    }
endgroup

// Covergroup for exclusive access during non-sequential transactions
covergroup cg_exclusive_access @(posedge HCLK); 
    option.per_instance = 1;

    EXCLUSIVE_ACCESS_COVER: coverpoint {HTRANS, HSEL, HREADY} iff ((HTRANS == 2'b01) | (HTRANS == 2'b10)) {
        bins exclusive_access = {2'b01, 1, 1};
    }
endgroup
// Covergroup for address alignment coverage
covergroup cg_address_alignment @(posedge HCLK); 
    option.per_instance = 1;

    ADDRESS_ALIGNMENT_COVER: coverpoint {HSIZE, HADDR[1:0]} iff (HSEL == 1) {
        bins byte_aligned = {3'b000, 3'b001, 3'b010, 3'b011};
        bins halfword_aligned = {3'b100, 3'b101};
        bins word_aligned = {3'b110, 3'b111};
    }
endgroup

// Covergroup for burst transactions coverage
covergroup cg_burst_transactions @(posedge HCLK); 
    option.per_instance = 1;

    BURST_TRANSACTIONS_COVER: coverpoint {HBURST, HTRANS} iff (HSEL == 1) {
        bins single_transfer = {3'b000, 2'b00};
        bins incr_burst = {3'b001, 2'b01};
        bins wrap_burst = {3'b010, 2'b10};
        bins reserved_burst = {3'b011, 2'b11};
        bins incr4_burst = {3'b100, 2'b10};
        bins incr8_burst = {3'b101, 2'b10};
        bins incr16_burst = {3'b110, 2'b10};
        bins reserved_burst_2 = {3'b111, 2'b10};
    }
endgroup

// Covergroup for valid HWDATA during write transactions
covergroup cg_valid_hwdata_write @(posedge HCLK); 
    option.per_instance = 1;

    VALID_HWDATA_WRITE_COVER: coverpoint {HWRITE, HWDATA} iff ((HSEL == 1) && (HREADY == 1)) {
        bins valid_hwdata = {1, 1};
    }
endgroup

// Covergroup for valid HRDATA during read transactions
covergroup cg_valid_hrdata_read @(posedge HCLK); 
    option.per_instance = 1;

    VALID_HRDATA_READ_COVER: coverpoint {HREADYOUT, HRDATA} iff ((HSEL == 1) && (HREADYOUT == 1)) {
        bins valid_hrdata = {1, 1};
    }
endgroup

// Covergroup for non-idle transactions
covergroup cg_non_idle_transactions @(posedge HCLK); 
    option.per_instance = 1;

    NON_IDLE_TRANSACTIONS_COVER: coverpoint {HTRANS, HSEL} iff (HSEL == 1) {
        bins non_idle_transaction = {2'b01, 1};
    }
endgroup

// Covergroup for HSEL being deasserted during idle transactions
covergroup cg_hsel_idle @(posedge HCLK); 
    option.per_instance = 1;

    HSEL_IDLE_COVER: coverpoint {HTRANS, HSEL} iff (HTRANS == 2'b00) {
        bins idle_transaction = {2'b00, 0};
    }
endgroup

// Covergroup for HREADY being deasserted during idle transactions
covergroup cg_hready_idle @(posedge HCLK); 
    option.per_instance = 1;

    HREADY_IDLE_COVER: coverpoint {HTRANS, HREADY} iff (HTRANS == 2'b00) {
        bins idle_transaction = {2'b00, 0};
    }
endgroup

// Covergroup for HRESP being zero during idle transactions
covergroup cg_hresp_idle @(posedge HCLK); 
    option.per_instance = 1;

    HRESP_IDLE_COVER: coverpoint {HTRANS, HRESP} iff (HTRANS == 2'b00) {
        bins idle_transaction = {2'b00, 2'b00};
    }
endgroup


 initial begin
  cg_check cg = new();
 end


endmodule