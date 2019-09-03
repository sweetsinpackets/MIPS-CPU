module mem_wb(clk,      //no flush
                MEM_memout, MEM_aluout,
                MEM_writeaddress, 
                MEM_memtoreg, MEM_regwrite,
                WB_memout, WB_aluout,
                WB_writeaddress,
                WB_memtoreg, WB_regwrite);

    input clk;
    input [31:0] MEM_memout, MEM_aluout;
    input [4:0] MEM_writeaddress;
    input MEM_memtoreg, MEM_regwrite;

    output [31:0] WB_memout, WB_aluout;
    output [4:0] WB_writeaddress;
    output WB_memtoreg, WB_regwrite;

    reg [31:0] WB_memout, WB_aluout;
    reg [4:0] WB_writeaddress;
    reg WB_memtoreg, WB_regwrite;

    initial begin
      WB_memout <= 32'b0;
      WB_aluout <= 32'b0;
      WB_writeaddress <= 5'b0;
      WB_memtoreg <= 1'b0;
      WB_regwrite <= 1'b0;
    end

    always @ (posedge clk) begin
      WB_memout <= MEM_memout;
      WB_aluout <= MEM_aluout;
      WB_writeaddress <= MEM_writeaddress;
      WB_memtoreg <= MEM_memtoreg;
      WB_regwrite <= MEM_regwrite;
    end

endmodule