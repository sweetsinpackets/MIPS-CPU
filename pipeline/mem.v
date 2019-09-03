    //INPUT: clk, alu_out, data to write
    //OUTPUT: data read
    //CONTROL: memread (control), memwrite (control)

module mem(clk, address, data, out, memread, memwrite);
    input clk;
    input [31:0] address, data;
    output reg[31:0] out;
    input memread, memwrite;

    parameter size = 64;    //the size of memory
    reg [31:0] memory [0:size-1];   //the data memory

    //initialize to 0
    integer i;
    initial begin
      for(i=0; i<size; i=i+1)
        memory[i] = 32'b0;
    end

    always @(address[31:2], memread, memory[address>>2]) begin
            if (memread) out=memory[address>>2];
    end
        always @(posedge clk) begin
            
            if (memwrite) memory[address>>2]=data;
        end

endmodule



