module pc (
    input  logic clk,
    input  logic reset,
    input  logic [31:0] pc_next,
    output logic [31:0] pc_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 32'h00000000;
        else
            pc_out <= pc_next;
    end

endmodule