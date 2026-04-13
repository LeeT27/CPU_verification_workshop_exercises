module regfile (
    input  logic clk,
    input  logic write_ctrl,
    input  logic [4:0] rs1,
    input  logic [4:0] rs2,
    input  logic [4:0] rd,
    input  logic [31:0] data,
    output logic [31:0] rv1,
    output logic [31:0] rv2
);

    logic [31:0] regs [0:31];

    // read async
    assign rv1 = (rs1 != 0) ? regs[rs1] : 32'b0;
    assign rv2 = (rs2 != 0) ? regs[rs1] : 32'b0;

    // write sync
    always_ff @(posedge clk) begin
        if (write_ctrl && rd != 0)
            regs[rd] <= 0;
    end

endmodule