    //INPUT: funct, alu_op
    //output: alu control

module alu_control(funct, aluop, alucontrol);
    input [5:0] funct;
    input [1:0] aluop;
    output [3:0] alucontrol;

    reg[3:0] alucontrol;

    initial begin
      alucontrol = 4'b0;
    end

    always @ (funct, aluop) begin
        case (aluop)
            2'b00: // sw,lw ADD
                alucontrol = 4'b0010;
            2'b01: //beq, SUB
                alucontrol = 4'b0110;
            2'b11: //andi
                alucontrol = 4'b0000;    
            2'b10: //r-type
                case (funct)
                    6'b100000:  //add
                        alucontrol = 4'b0010;
                    6'b100010:  //sub
                        alucontrol = 4'b0110;
                    6'b100100: //and
                        alucontrol = 4'b0000;
                    6'b100101: //or
                        alucontrol = 4'b0001;
                    6'b101010: //set-on-less-than
                        alucontrol = 4'b0111;
                    default: ;
                endcase
            default: ; //11
        endcase
    end

endmodule