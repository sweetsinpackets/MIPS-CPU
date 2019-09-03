`timescale 1ns / 1ps

module hazard_detection(
    stall, flush,
    ID_branch_beq, ID_branch_bne,   
    ID_Rs, ID_Rt,   //use
    EX_writeaddress, MEM_writeaddress,  //write address
    EX_Rt,          //might write to by lw
    MEM_memread,
    EX_memread,     
    EX_regwrite);     //R-type

    input ID_branch_beq, ID_branch_bne,
          MEM_memread, EX_memread, EX_regwrite;
    input [4:0] ID_Rs, ID_Rt, EX_Rt,
                MEM_writeaddress, EX_writeaddress;
    output stall, flush;
    reg stall, flush;

    initial begin
      stall = 1'b0;
      flush = 1'b1;
    end

    always @ ( ID_branch_beq, ID_branch_bne, ID_Rs, ID_Rt,   
    EX_writeaddress, MEM_writeaddress, EX_Rt, MEM_memread,
    EX_memread, EX_regwrite)    begin
        //mem read, use before read
        //ID-EX after a clock, EX-MEM, require EX-WB
        if (EX_memread && EX_Rt && ((ID_Rs == EX_Rt) || (ID_Rt == EX_Rt)) ) begin
            stall = 1'b1; 
            flush = 1'b1;
        end
        //cause by branch
        else if (ID_branch_beq || ID_branch_bne) begin
            //need data after ALU, but enter EX stage
            if (EX_regwrite && (EX_writeaddress!=0)
                && ((ID_Rs == EX_writeaddress) || (ID_Rt == EX_writeaddress)) ) begin
                stall = 1'b1;
                flush = 1'b1;
            end
            //need memread, but enter MEM stage
            else if (MEM_memread && (MEM_writeaddress!=0)
                && ((ID_Rs == MEM_writeaddress) || (ID_Rt == MEM_writeaddress))) begin
                stall = 1'b1;
                flush = 1'b1;
            end
            else begin
                stall = 1'b0;
                flush = 1'b0;
            end
            end
        else begin
            stall = 1'b0;
            flush = 1'b0;
        end

    end

endmodule
