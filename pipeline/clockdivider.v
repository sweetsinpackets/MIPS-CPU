`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/19 16:07:33
// Design Name: 
// Module Name: clockdivider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clockdivider(clock_out2,clock_in);
  input clock_in;
  output clock_out2;
  
  reg [17:0]R;
  reg clock_out1;
  reg clock_out2;
  always @ (posedge clock_in)begin
    if(R==200000)begin
          clock_out2<=1;
          R<=0;
    end
    else begin
          clock_out2<=0;
          R<=R+1;
    end
    
  end
endmodule
