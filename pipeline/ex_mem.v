module ex_mem(clk,      
              EX_aluout, EX_regout,
              EX_writeaddress,
              EX_memread, EX_memtoreg, EX_memwrite, EX_regwrite,
              MEM_aluout, MEM_regout, 
              MEM_writeaddress,
              MEM_memread, MEM_memtoreg, MEM_memwrite, MEM_regwrite);

    input clk;
    input [31:0] EX_aluout, EX_regout;
    input [4:0] EX_writeaddress;
    input EX_memread, EX_memtoreg, EX_memwrite, EX_regwrite;

//    output clk;
    output [31:0] MEM_aluout, MEM_regout;
    output [4:0] MEM_writeaddress;
    output MEM_memread, MEM_memtoreg, MEM_memwrite, MEM_regwrite;

//    reg clk;
    reg [31:0] MEM_aluout, MEM_regout;
    reg [4:0] MEM_writeaddress;
    reg MEM_memread, MEM_memtoreg, MEM_memwrite, MEM_regwrite;

    initial begin
      MEM_aluout <= 32'b0;
      MEM_regout <= 32'b0;
      MEM_writeaddress <= 5'b0;
      MEM_memread <= 1'b0;
      MEM_memtoreg <= 1'b0;
      MEM_memwrite <= 1'b0;
      MEM_regwrite <= 1'b0;
    end

    always @ (posedge clk) begin
      MEM_aluout <= EX_aluout;
      MEM_regout <= EX_regout;
      MEM_writeaddress <= EX_writeaddress;
      MEM_memread <= EX_memread;
      MEM_memtoreg <= EX_memtoreg;
      MEM_memwrite <= EX_memwrite;
      MEM_regwrite <= EX_regwrite;
    end
endmodule