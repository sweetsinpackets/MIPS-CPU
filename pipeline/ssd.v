`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/19 16:25:36
// Design Name: 
// Module Name: ssd
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


module ssd(
input clk,
input [31:0]in,
output reg [3:0]an,
output reg [6:0]ssd
    );
reg [3:0]number;
reg [1:0]counter;
always @(posedge clk)begin
    counter<=counter+1;
    case (counter)
        2'b00:begin
            an<=4'b1110;
            number<=in[3:0];
        end
        2'b01:begin
            an<=4'b1101;
            number<=in[7:4];
        end
        2'b10:begin
            an<=4'b1011;
            number<=in[11:8];
        end
        2'b11:begin
            an<=4'b0111;
            number<=in[15:12];
        end
        default an<=4'b1111;
    endcase
end 
always @(number)
    case(number)
      4'b0000: ssd <= 7'b0000001;
      4'b0001: ssd <= 7'b1001111;
      4'b0010: ssd <= 7'b0010010;
      4'b0011: ssd <= 7'b0000110;
      4'b0100: ssd <= 7'b1001100;
      4'b0101: ssd <= 7'b0100100;
      4'b0110: ssd <= 7'b0100000;
      4'b0111: ssd <= 7'b0001111;
      4'b1000: ssd <= 7'b0000000;
      4'b1001: ssd <= 7'b0000100;
      4'b1010: ssd <= 7'b0001000;
      4'b1011: ssd <= 7'b1100000;
      4'b1100: ssd <= 7'b0110001;
      4'b1101: ssd <= 7'b1000010;
      4'b1110: ssd <= 7'b0110000;
      4'b1111: ssd <= 7'b0111000;
    endcase   
endmodule


