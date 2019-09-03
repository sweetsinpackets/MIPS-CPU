module id_ex(clk, flush_ID_EX,
            ID_regout1, ID_regout2, 
            ID_signextension, 
            ID_Rs, ID_Rt, ID_Rd,
            ID_regdst, ID_memread, ID_memwrite, ID_memtoreg,
            ID_aluop, ID_alusrc, ID_regwrite,
            EX_regout1, EX_regout2,
            EX_signextension,
            EX_Rs, EX_Rt, EX_Rd,
            EX_regdst, EX_memread, EX_memwrite, EX_memtoreg,
            EX_aluop, EX_alusrc, EX_regwrite);

    input clk, flush_ID_EX;
    input [31:0] ID_regout1, ID_regout2, ID_signextension;
    input [4:0] ID_Rs, ID_Rt, ID_Rd;
    input [1:0] ID_aluop;
    input ID_regdst, ID_memread, ID_memwrite, ID_memtoreg,
            ID_alusrc, ID_regwrite;

    output [31:0] EX_regout1, EX_regout2, EX_signextension;
    output [4:0] EX_Rs, EX_Rt, EX_Rd;
    output [1:0] EX_aluop;
    output EX_regdst, EX_memread, EX_memwrite, EX_memtoreg,
             EX_alusrc, EX_regwrite;

    reg [31:0] EX_regout1, EX_regout2, EX_signextension;
    reg [4:0] EX_Rs, EX_Rt, EX_Rd;
    reg [1:0] EX_aluop;
    reg EX_regdst, EX_memread, EX_memwrite, EX_memtoreg,
             EX_alusrc, EX_regwrite;

    initial begin
      EX_regout1 <= 32'b0;
      EX_regout2 <= 32'b0;
      EX_signextension <= 32'b0;
      EX_Rs <= 5'b0;
      EX_Rt <= 5'b0;
      EX_Rd <=5'b0;
      EX_regdst <= 0;
      EX_memread <= 0;
      EX_memwrite <= 0;
      EX_memtoreg <= 0;
      EX_aluop <= 2'b0;
      EX_alusrc <= 0;
      EX_regwrite <= 0;
    end

    always @ (posedge clk) begin
        if (flush_ID_EX) begin
            EX_regdst <= 1'b0;
            EX_memread <= 1'b0;
            EX_memwrite <= 1'b0;
            EX_memtoreg <= 1'b0;
            EX_aluop <= 2'b0;
            EX_alusrc <= 1'b0;
            EX_regwrite <= 1'b0;
        end
        else begin
            EX_regout1 <= ID_regout1;
            EX_regout2 <= ID_regout2;
            EX_signextension <= ID_signextension;
            EX_Rs <= ID_Rs;
            EX_Rt <= ID_Rt;
            EX_Rd <= ID_Rd;
            EX_regdst <= ID_regdst;
            EX_memread <= ID_memread;
            EX_memwrite <= ID_memwrite;
            EX_memtoreg <= ID_memtoreg;
            EX_aluop <= ID_aluop;
            EX_alusrc <= ID_alusrc;
            EX_regwrite <= ID_regwrite;
        end
    end
endmodule