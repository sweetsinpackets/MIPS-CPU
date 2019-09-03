    //clock signal, read 1, read 2,  read out1, read out2
    //write address, write data, write control
module register(clk, read1, read2, out1, out2, write_address, write_Data, write);
    input clk, write;
    input [4:0] read1, read2, write_address;
    input [31:0] write_Data;
    output [31:0] out1, out2;

    reg [31:0] regs [0:31];
    integer i;

    //initialize to 0
    initial begin
      for(i=0; i<32; i=i+1)
        regs[i] = 32'b0;
    end

    //always read
    assign out1 = regs[read1];
    assign out2 = regs[read2];
    
    always @ (negedge clk) begin
        if (write == 1)
            regs[write_address] <= write_Data;
    end

endmodule