//NAME: Stage_original name(not capital)

module pipeline(clk,clk2,pcsw,regselect,an,ssd);
    input clk;
    input clk2;
    input pcsw;
    input [4:0]regselect;
    output  [3:0]an;
    output [6:0] ssd;
    wire clk_dvd;
    wire [3:0]wan;
    wire [6:0]wssd;
    wire [31:0]in_ssd;
     
//========================================
//PIPELINE STRUCTURE
//========================================
//within IF
    wire [31:0] IF_pcin,
                IF_pcout,
                IF_pcadd4,
                IF_instruction,
                IF_branchout;

//within ID
        //datas
    wire [31:0] ID_pcadd4,
                ID_instruction,
                ID_pcaddout,
                ID_regout1,
                ID_regout2,
                ID_regout1_forward,
                ID_regout2_forward,
                ID_signextension,
                ID_jumpaddress;
        //address
    wire [4:0] ID_Rs,
               ID_Rt,
               ID_Rd;
        //control
    wire [1:0] ID_aluop;

    wire  ID_regdst,
          ID_jump,
          ID_branch_beq,
          ID_branch_bne,
          ID_memread,
          ID_memwrite,
          ID_memtoreg,
          ID_alusrc,
          ID_regwrite,
          ID_branch;

        //To deal with control hazard
    wire  ID_readout_ifequal;
//within EX
        //data
    wire [31:0] EX_regout1,
                EX_regout2,
                EX_signextension,
                EX_aluin1,
                EX_aluin2_beforemax,
                EX_aluin2,
                EX_aluout;

        //address
    wire [4:0] EX_Rs,
               EX_Rd,
               EX_Rt,
               EX_writeaddress; //serves as the register to write in

        //control
    wire [3:0] EX_alucontrol;
    wire [1:0] EX_aluop;
    wire   EX_regdst,
           EX_memread,
           EX_memtoreg,
           EX_memwrite,
           EX_alusrc,
           EX_regwrite,
           EX_aluzero;
//within mem
        //data
    wire [31:0] MEM_aluout,
                MEM_regout, //the data read from ID in register file
                MEM_memout;

        //address
    wire [4:0] MEM_writeaddress;

        //control
    wire  MEM_memread,
          MEM_memtoreg,
          MEM_memwrite,
          MEM_regwrite;
//within WB
        //data
    wire [31:0] WB_aluout,
                WB_memout,
                WB_writedata;

        //address
    wire [4:0] WB_writeaddress;

        //control
    wire  WB_memtoreg,
          WB_regwrite;


//========================================
//HAZARD
//========================================
    //control
    wire flush_IF_ID, 
         flush_ID_EX,
         stall;

    //data
    wire [1:0] EX_forward1,
               EX_forward2;

    wire    ID_forward1,
            ID_forward2;

//========================================
//CONSTRUCT 
//========================================

//IF stage

//branch is in ID stage



pc PC(clk, IF_pcin, IF_pcout, stall);
im Instruction(IF_pcout, IF_instruction); 
assign IF_pcadd4 = IF_pcout +4;

// IF-ID reg

if_id IF_ID(clk, stall, flush_IF_ID, 
            IF_pcadd4, IF_instruction,
            ID_pcadd4, ID_instruction);


// ID stage

assign ID_Rs = ID_instruction[25:21];
assign ID_Rt = ID_instruction[20:16];
assign ID_Rd = ID_instruction[15:11];

sign_extension SignExtension(ID_instruction[15:0], ID_signextension);

//opcode, regdst, jump, branch_beq,branch_bne, memread, memtoreg,
//memwrite, regwrite, alusrc, aluop
control Control(ID_instruction[31:26], 
                ID_regdst, ID_jump, ID_branch_beq, ID_branch_bne,
                ID_memread, ID_memtoreg, ID_memwrite, ID_regwrite,
                ID_alusrc, ID_aluop);

//clk, read1, read2, out1, out2, write_address, write_Data, write
register Register(clk, ID_Rs, ID_Rt, ID_regout1, ID_regout2
                  , WB_writeaddress, WB_writedata,
                  WB_regwrite);


assign ID_pcaddout = ID_pcadd4 + (ID_signextension << 2);
//to do forwarding on ID stage of control hazard Branch
assign ID_regout1_forward = (ID_forward1) ? MEM_aluout : ID_regout1;
assign ID_regout2_forward = (ID_forward2) ? MEM_aluout : ID_regout2;

assign ID_readout_ifequal = (ID_regout1_forward == ID_regout2_forward);
assign ID_jumpaddress = {ID_pcadd4[31:28], ID_instruction[25:0], 2'b0};
assign ID_branch = (ID_branch_beq && ID_readout_ifequal) || (ID_branch_bne && !ID_readout_ifequal);
assign IF_branchout = (ID_branch) ? ID_pcaddout : IF_pcadd4;
assign IF_pcin = (ID_jump) ? ID_jumpaddress : IF_branchout;

//dealing with branch control hazard
assign flush_IF_ID = (ID_branch && (!stall)) | ID_jump;


//ID-EX reg

id_ex ID_EX(clk, flush_ID_EX,
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


//EX stage

alu_mux ALU_MUX1(EX_forward1, EX_aluin1, EX_regout1, WB_writedata, MEM_aluout);
alu_mux ALU_MUX2(EX_forward2, EX_aluin2_beforemax, EX_regout2, WB_writedata, MEM_aluout);
assign EX_aluin2 = (EX_alusrc) ? EX_signextension : EX_aluin2_beforemax;
alu_control ALU_CONTROL(EX_signextension[5:0], EX_aluop, EX_alucontrol);
alu ALU(EX_aluin1, EX_aluin2, EX_alucontrol, EX_aluout, EX_aluzero);

assign EX_writeaddress = (EX_regdst) ? EX_Rd : EX_Rt;

// EX-MEM reg

ex_mem EX_MEM(clk,      //no flush
              EX_aluout, EX_aluin2_beforemax,
              EX_writeaddress,
              EX_memread, EX_memtoreg, EX_memwrite, EX_regwrite,
              MEM_aluout, MEM_regout, 
              MEM_writeaddress,
              MEM_memread, MEM_memtoreg, MEM_memwrite, MEM_regwrite);

// MEM stage

mem MEMORY(clk, MEM_aluout, MEM_regout, MEM_memout, MEM_memread, MEM_memwrite);

// MEM-WB reg

mem_wb MEM_WB(clk,      //no flush
                MEM_memout, MEM_aluout,
                MEM_writeaddress, 
                MEM_memtoreg, MEM_regwrite,
                WB_memout, WB_aluout,
                WB_writeaddress,
                WB_memtoreg, WB_regwrite);

// WB stage

assign WB_writedata = (WB_memtoreg==1) ? WB_memout : WB_aluout;
        //note that memtoreg = 1 means memory





//========================================
//Forwarding
//========================================

forward FORWARD(
    EX_forward1, EX_forward2,
    ID_forward1, ID_forward2,
    ID_Rs, ID_Rt, 
    EX_Rs, EX_Rt,
    MEM_writeaddress, WB_writeaddress,
    MEM_regwrite, WB_regwrite);

//========================================
//Hazard_Detection
//========================================
hazard_detection Hazard_Detection(
    stall, flush_ID_EX,
    ID_branch_beq, ID_branch_bne,   
    ID_Rs, ID_Rt,   //use
    EX_writeaddress, MEM_writeaddress,  //write address
    EX_Rt,          //might write to by lw
    MEM_memread,
    EX_memread,     
    EX_regwrite);     //R-type


    clockdivider CLKDVD(clk_dvd,clk2);
    ssd SSD(clk_dvd,in_ssd,wan,wssd);
    assign in_ssd= (pcsw) ? IF_pcout : Register.regs[regselect];
    assign an=wan;
    assign ssd=wssd;
endmodule