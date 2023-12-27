
module assertion_module#(
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

// Assertion for HREADYOUT being asserted only when HREADY is asserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HREADY) |-> (HREADYOUT)
    );

// Assertion for HREADYOUT being deasserted only when HREADY is deasserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    !(HREADY) |-> !(HREADYOUT)
    );

// Assertion for HREADY being asserted only when HREADYOUT is asserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HREADYOUT == 1) |-> (HREADY == 1)
    );

// Assertion for HREADY being deasserted only when HREADYOUT is deasserted
assert property (
      @(posedge HCLK) disable iff(!HRESETn)
    (HREADYOUT == 0) |-> (HREADY == 0)
    );

// Assertion for valid HADDR when HSEL is asserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HSEL == 1) |-> (HADDR !== 16'hxxxx)
    );

// Assertion for valid HWDATA when HWRITE is asserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HWRITE == 1) |-> (HWDATA !== 32'hxxxxxxxx)
    );

// Assertion for valid HRDATA when HREADYOUT is asserted
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HREADYOUT == 1) |-> (HRDATA !== 32'hxxxxxxxx)
    );

// Assertion for valid HSIZE values
assert property (
      @(posedge HCLK) disable iff(!HRESETn)
    ((HSIZE == 3'b000) | (HSIZE == 3'b001) | (HSIZE == 3'b010) | (HSIZE == 3'b011) |
     (HSIZE == 3'b100) | (HSIZE == 3'b101) | (HSIZE == 3'b110) | (HSIZE == 3'b111))
     );

// Assertion for valid HBURST values
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    ((HBURST == 3'b000) | (HBURST == 3'b001) | (HBURST == 3'b010) | (HBURST == 3'b011) |
     (HBURST == 3'b100) | (HBURST == 3'b101) | (HBURST == 3'b110) | (HBURST == 3'b111))
     );

// Assertion for valid HPROT values
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    ((HPROT == 4'b0000) | (HPROT == 4'b0001) | (HPROT == 4'b0010) | (HPROT == 4'b0011) |
     (HPROT == 4'b0100) | (HPROT == 4'b0101) | (HPROT == 4'b0110) | (HPROT == 4'b0111) |
     (HPROT == 4'b1000) | (HPROT == 4'b1001) | (HPROT == 4'b1010) | (HPROT == 4'b1011) |
     (HPROT == 4'b1100) | (HPROT == 4'b1101) | (HPROT == 4'b1110) | (HPROT == 4'b1111))
     );

// Assertion for valid HTRANS values
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    ((HTRANS == 2'b00) | (HTRANS == 2'b01) | (HTRANS == 2'b10) | (HTRANS == 2'b11))
    );

// Assertion for valid HRESP values
assert property (
      @(posedge HCLK) disable iff(!HRESETn)
    ((HRESP == 2'b00) | (HRESP == 2'b01) | (HRESP == 2'b10))
    );


// Assertion for valid HADDR alignment based on HSIZE
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    ((HSIZE == 3'b00) && ((HADDR[1:0] == 2'b00) | (HADDR[1:0] == 2'b01))) |
    ((HSIZE == 3'b01) && (HADDR[0] == 1'b0)) |
    ((HSIZE == 3'b10) && (HADDR[1:0] == 2'b00))
    );

// Assertion for HRDATA being stable during the HREADYOUT assertion
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HREADYOUT == 1) |-> ($stable(HRDATA))
    );

// Assertion for exclusive access when HTRANS is non-sequential
assert property (
     @(posedge HCLK) disable iff(!HRESETn)
    ((HTRANS == 2'b01) | (HTRANS == 2'b10)) |-> ((HSEL == 1) && (HREADY == 1))
    );

// Assertion for valid HWDATA during write transactions
assert property (
      @(posedge HCLK) disable iff(!HRESETn)
    (HWRITE == 1) |-> (HWDATA !== 32'hzzzzzzzz)
    );

// Assertion for HRESP being valid only during the HREADYOUT assertion
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HREADYOUT == 1) |-> (HRESP !== 2'bzz)
    );

// Assertion for HBURST being valid only during burst transactions
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    ((HBURST != 3'b000) && (HTRANS == 2'b10)) |-> (HREADY == 1)
    );

// Assertion for HPROT being valid only during non-idle transactions
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HTRANS != 2'b00) |-> ((HPROT !== 4'bzzzz) && (HREADY == 1))
    );

// Assertion for HSEL being deasserted during an idle transaction
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HTRANS == 2'b00) |-> (HSEL == 0)
    );

// Assertion for HREADY being deasserted during an idle transaction
assert property (
    @(posedge HCLK) disable iff(!HRESETn)
    (HTRANS == 2'b00) |-> (HREADY == 0)
    );

// Assertion for HRESP being zero during an idle transaction
assert property (
      @(posedge HCLK) disable iff(!HRESETn)
    (HTRANS == 2'b00) |-> (HRESP == 2'b00)
    );

endmodule
