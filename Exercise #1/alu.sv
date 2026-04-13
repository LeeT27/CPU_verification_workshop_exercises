module alu (
    input  logic [31:0] a,        // Operand 1
    input  logic [31:0] b,        // Operand 2
    input  logic [2:0]  alu_ctrl, // Operation select
    output logic [31:0] result    // Result
);

    always @(*) begin
        case (alu_ctrl)
            3'b000: result = a + b;        // ADD
            3'b001: result = a - b;        // SUB
            3'b010: result = a & b;        // AND
            3'b011: result = a | b;        // OR
            3'b100: result = a ^ b;        // XOR
            3'b101: result = a << b[4:0];  // SLL (shift left)
            3'b110: result = a >> b[4:0];  // SRL (shift right)
            3'b111: result = (a < b) ? 32'd1 : 32'd0; // SLT (Set less than)

            default: result = 32'd0;
        endcase
    end

endmodule