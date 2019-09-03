//might use multi-condition-expression to instead it
//function calling might need extra time

//module alu_mux(forward, out, EX_in, WB_in, MEM_in);
//    input [1:0] forward;
//    input [31:0] EX_in, WB_in, MEM_in;
//    output [31:0] out;

module alu_mux(
    input       [1:0] forward,
    output reg  [31:0] out,
    input       [31:0] EX_in, WB_in, MEM_in
);    
    
    always @ (EX_in, WB_in, MEM_in, forward) begin
      if (forward == 2'b00)
        out = EX_in;
      else if (forward == 2'b01)
        out = WB_in;
      else if (forward == 2'b10)
        out = MEM_in;
//        case (forward)
//            2'b00:   begin out = EX_in; end
//            2'b01:   begin out = WB_in; end
//            2'b10:   begin out = MEM_in; end
//        endcase
    end

endmodule