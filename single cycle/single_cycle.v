//might have error: sign_extension
//might can improve: data memory

module single_cycle(clk);
    input clk;

    wire [31:0] pc_in, pc_out,  //pc
                pc_add_4,   //pc+4, to shift
                instruction,    //acturally 25-0
                jump_address,
                add_output,     //branch alu
                branch_address;

//end of pc-related

    wire [4:0] regwrite_address;    //distination
    wire [31:0] regwrite_data,
                regread_data1,
                regread_data2;      //reg part

//end of reg-related

    wire [31:0] sign_extension;     //ID stage

    wire [31:0] alu_in,
                alu_out;        //EX stage, ALU
    
    wire [3:0] alu_control;     //4-bit control

    wire alu_zero;              //zero output

//end of alu-related

    wire [31:0] mem_read;

//end of mem-stage

    wire branch,    //1bit control
         regdst,
         jump,
         branch_beq,    //support beq
         branch_bne,    //support neq
         memtoreg,
         memread,
         memwrite,
         alusrc,
         regwrite;      //all output of control

    wire [1:0] aluop;   //2bit control

//end of declaration



  assign pc_add_4 = pc_out + 4;
    assign pc_in = jump == 0 ? branch_address : jump_address; 
            //act as a mux (second)
    assign add_output = pc_add_4 + (sign_extension<< 2);
    assign jump_address = {pc_add_4[31:28], instruction[25:0], 2'b0};
    assign branch_address = branch == 1 ? add_output : pc_add_4;
            //act as a mux (first)
    assign regwrite_address = regdst == 0 ? instruction[20:16] : instruction[15:11];
            //write register address mux
    assign regwrite_data = memtoreg == 0 ? alu_out : mem_read;
            //mux of reg write data in WB stage

    assign alu_in = alusrc == 0 ? regread_data2 : sign_extension;
            //mux of alu input

    assign branch = ((branch_beq && alu_zero) | (branch_bne && ~alu_zero) );
            // bne: not equal, zero = 0. beq, zero = 1
    
//end of assigning
    
    pc PC(clk, pc_in, pc_out);
    //clock, input, output

    im InstructionMemory(pc_out, instruction);
    //pc output, instruction output

    sign_extension SignExtension(instruction[15:0], sign_extension);
    //sign extension

    register Register(clk, instruction[25:21], instruction[20:16],
                            regread_data1, regread_data2,
                            regwrite_address, regwrite_data,
                            regwrite);
    //clock signal, read 1, read 2,  read out1, read out2
    //write address, write data, write control

    alu alu(regread_data1, alu_in, alu_control, alu_out, alu_zero);
    //input 1, input 2(mux), control, output, zero output

    mem mem(clk, alu_out, regread_data2, mem_read, memread, memwrite);
    //INPUT: clk, alu_out, data to write
    //OUTPUT: data read
    //CONTROL: memread (control), memwrite (control)

//controls
    control Control(instruction[31:26], 
                    regdst, jump, branch_beq,
                    branch_bne, memread, memtoreg,
                    memwrite, regwrite, alusrc, aluop);
    //opcode(input), OUTPUT: regDST, Jump, Branch beq, Branch bne,
    //memread, mem to reg, memwrite, regwrite, alu_src, alu_op

    alu_control ALU_Control(instruction[5:0], aluop, alu_control);
    //INPUT: funct, alu_op
    //output: alu control


endmodule