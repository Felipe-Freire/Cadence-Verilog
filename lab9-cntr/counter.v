module counter
#(
  parameter integer WIDTH = 5
 )
 (
  input  wire             enab,
  input  wire             load,
  input  wire             clk,
  input  wire             rst,
  input  wire [WIDTH-1:0] cnt_in,
  output reg  [WIDTH-1:0] cnt_out
 );

  reg [WIDTH-1:0] cnt_temp;

  always @* begin
    if ( rst  ) cnt_temp = 8'b0; else
    if ( load ) cnt_temp = cnt_in; else
    if ( enab ) cnt_temp = cnt_out + 1; else
                cnt_temp = cnt_out;               
  end

  always @(posedge clk) begin
    cnt_out = cnt_temp;
  end

endmodule
