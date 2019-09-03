  //input 1, input 2(mux), control, output, zero output
module alu(in1, in2, control, out, zero);
    input [31:0] in1, in2;
    input [3:0] control;
    output reg [31:0] out;
    output zero;

    //zero is related to result
    assign zero = (out == 0);

    //initialize
    initial begin
      out = 32'b0;
    end

    always @ (control, in1, in2) begin
        case(control)
            4'b0000: //and
                out = in1 & in2;
            4'b0001: //or
                out = in1 | in2;
            4'b0010: //sum
                out = in1 + in2;
            4'b0110: //minus
                out = in1 - in2;
            4'b0111: //less
                out = in1<in2 ? 1:0;
            4'b1100: //nor
                out = ~(in1|in2);
        endcase
    end

endmodule
