module sign_extension(in, out);
    input [15:0] in;
    output reg [31:0] out;
      always @(in)begin
      if (in[15]==1'b0)
         out <= 32'b0+in[15:0]; 
       else
       out<=32'b11111111111111110000000000000000+in[15:0]; 
      end 
    //no not need initalize
endmodule
