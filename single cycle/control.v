//opcode(input), OUTPUT: regDST, Jump, Branch beq, Branch bne,
    //memread, mem to reg, memwrite, regwrite, alu_src, alu_op
module control(opcode,
                    regdst, jump, branch_beq,
                    branch_bne, memread, memtoreg,
                    memwrite, regwrite, alusrc, aluop);
    
    input [5:0] opcode;
    output regdst, jump, branch_beq,
                branch_bne, memread, memtoreg,
                memwrite, regwrite, alusrc;
    output [1:0] aluop;

    reg regdst, jump, branch_beq,
                branch_bne, memread, memtoreg,
                memwrite, regwrite, alusrc;

    reg [1:0] aluop;

    //use <= instead of = to avoid order chaos

    initial begin
        regdst <= 1'b0;
        jump <= 1'b0;
        branch_beq <= 1'b0;
        branch_bne <= 1'b0;
        memread <= 1'b0;
        memtoreg <= 1'b0;
        memwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrc <= 1'b0;
        aluop <= 2'b00;
    end


    always @(opcode) begin
        case (opcode)
            6'b000000: begin    //r-type
                regdst <= 1'b1;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b1;
                alusrc <= 1'b0;
                aluop <= 2'b10;
            end
            6'b100011: begin    //lw
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b1;
                memtoreg <= 1'b1;
                memwrite <= 1'b0;
                regwrite <= 1'b1;
                alusrc <= 1'b1;
                aluop <= 2'b00;
            end            
            6'b101011: begin    //sw
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b1;
                regwrite <= 1'b0;
                alusrc <= 1'b1;
                aluop <= 2'b00;
            end
            6'b001000: begin    //addi
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b1;
                alusrc <= 1'b1;
                aluop <= 2'b00;
            end
            6'b001100: begin    //andi
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b1;
                alusrc <= 1'b1;
                aluop <= 2'b11;
            end
            6'b000100: begin    //beq
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b1;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b0;
                alusrc <= 1'b0;
                aluop <= 2'b01;
            end
            6'b000101: begin    //bne
                regdst <= 1'b0;
                jump <= 1'b0;
                branch_beq <= 1'b0;
                branch_bne <= 1'b1;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b0;
                alusrc <= 1'b0;
                aluop <= 2'b01;
            end
            6'b000010: begin    //j
                regdst <= 1'b0;
                jump <= 1'b1;
                branch_beq <= 1'b0;
                branch_bne <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                memwrite <= 1'b0;
                regwrite <= 1'b0;
                alusrc <= 1'b0;
                aluop <= 2'b10;
            end
        endcase
    end

endmodule