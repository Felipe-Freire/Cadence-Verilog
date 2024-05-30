module register 
#(
  parameter WIDTH = 8
 )
 (
  input  wire             load,
  input  wire             clk,
  input  wire             rst,
  input  wire [WIDTH-1:0] data_in,
  output reg  [WIDTH-1:0] data_out
 );
 
  always @(posedge clk) begin
    if (rst == 1)  data_out <= 8'b0;    else
    if (load == 1) data_out <= data_in; else
                   data_out <= data_out;
  end
  
endmodule
