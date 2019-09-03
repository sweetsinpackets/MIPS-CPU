module if_id(clk, stall, flush, 
                IF_pcadd4, IF_instruction, 
                ID_pcadd4, ID_instruction);
    input clk, stall, flush;
    input [31:0] IF_pcadd4, IF_instruction;
    output [31:0] ID_pcadd4, ID_instruction;
    reg [31:0] ID_pcadd4, ID_instruction;

    initial begin
        ID_pcadd4 = 32'b0;
        ID_instruction = 32'b0;
    end
    always @ (posedge clk) begin
        if (!stall)  begin
                ID_pcadd4 <= IF_pcadd4;
                ID_instruction <= IF_instruction;
            end
        else;            
        if(flush) begin
            ID_pcadd4 <= 32'b0;
            ID_instruction <= 32'b0;
        end
        else;        
    end
endmodule