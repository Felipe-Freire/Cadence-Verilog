module memory
#(
  parameter AWIDTH = 5,
  parameter DWIDTH = 8
 )
 (
  input wire              clk,
  input wire              wr,
  input wire              rd,
  input wire [AWIDTH-1:0] addr,
  inout wire [DWIDTH-1:0] data
 );
  
  reg [DWIDTH-1:0] memo [0:2**AWIDTH-1];

  always @(posedge clk)
    if (wr) memo[addr] = data;

  assign data = rd ? memo[addr] : 'bz;
    
endmodule
