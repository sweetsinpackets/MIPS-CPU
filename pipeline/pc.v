module pc(clk, pc_in, pc_out, stall);
    input clk, stall;
    input [31:0] pc_in;
    output [31:0] pc_out;
    reg [31:0] pc_out;
    initial begin
        pc_out <= 32'b11111111111111111111111111111100;
    end
    always @(posedge clk) begin
        if (!stall)
            pc_out <= pc_in;
    end
endmodule