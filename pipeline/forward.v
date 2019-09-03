`timescale 1ns / 1ps

//forward FORWARD(
//    EX_forward1, EX_forward2,
//    ID_forward1, ID_forward2,
//    ID_Rs, ID_Rt, 
//    EX_Rs, EX_Rt,
//    MEM_writeaddress, WB_writeaddress,
//    MEM_regwrite, WB_regwrite);
module forward(
        //    EX_forward1, EX_forward2,
        //    ID_forward1, ID_forward2,
        output reg  [1:0]forwardA,
        output reg  [1:0]forwardB,
        output reg  forwardC,
        output reg  forwardD,
        //    ID_Rs, ID_Rt, 
        //    EX_Rs, EX_Rt,
        input       [4:0]reg_rs_ID,
        input       [4:0]reg_rt_ID,
        input       [4:0]reg_rs_EX,
        input       [4:0]reg_rt_EX,
        //    MEM_writeaddress, WB_writeaddress,
        //    MEM_regwrite, WB_regwrite
        input       [4:0]reg_rd_MEM,
        input       [4:0]reg_rd_WB,
        input       regwrite_MEM,
        input       regwrite_WB
    );
    always @(*)
    begin
        // forward A:during EX rs need result in MEM or WB
        if          (regwrite_MEM && reg_rd_MEM!=0 && reg_rd_MEM==reg_rs_EX)    forwardA = 2'b10;
        else if    (regwrite_WB  && reg_rd_WB!=0  && reg_rd_WB==reg_rs_EX)     forwardA = 2'b01;
        else        forwardA = 2'b00;
        // forward B:during EX rt need result in MEM or WB
        if          (regwrite_MEM && reg_rd_MEM!=0 && reg_rd_MEM==reg_rt_EX)    forwardB = 2'b10;
        else if    (regwrite_WB  && reg_rd_WB!=0  && reg_rd_WB==reg_rt_EX)     forwardB = 2'b01;
        else        forwardB = 2'b00;
        // forward C:during ID rs need result in MEM or WB 
        if          (regwrite_MEM && reg_rd_MEM!=0 && reg_rd_MEM==reg_rs_ID)    forwardC = 1'b1;
        else        forwardC = 1'b0;
        // forward D:during ID rt need result in MEM or WB 
        if          (regwrite_MEM && reg_rd_MEM!=0 && reg_rd_MEM==reg_rt_ID)    forwardD = 1'b1;
        else        forwardD = 1'b0;
    end
    initial begin forwardA = 2'b00; forwardB = 2'b00; forwardC = 1'b0; forwardD = 1'b0; end
    
endmodule
