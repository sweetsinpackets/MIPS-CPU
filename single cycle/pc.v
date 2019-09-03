module pc(clk, pc_in, pc_out);
    input clk;
    input [31:0] pc_in;
    output [31:0] pc_out;

    reg [31:0] pc_out;
    initial begin
        
        pc_out <= -4;
    end
    always @(posedge clk) begin
      pc_out <= pc_in;
    end

    

endmodule