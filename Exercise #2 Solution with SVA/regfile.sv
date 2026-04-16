module regfile(
    input  logic clk,
    input  logic write_ctrl, // Toggle writes on or off
    input  logic [4:0] rs1, // Source register #1 address
    input  logic [4:0] rs2, // Source register #2 address
    input  logic [4:0] rd, // Destination register address
    input  logic [31:0] data, // Data to write in destination register
    output logic [31:0] rv1, // Data read from rs1
    output logic [31:0] rv2 // Data read from rs2
    );

    logic [31:0] registers [31:0]; // 32 registers of size 32 bits

    assign rv1 = registers[rs1];
    assign rv2 = registers[rs2];

    always @(posedge clk) begin
        if (write_ctrl)
            begin
                registers[rd] <= data; // Change data is destination register to new data
            end
    end

endmodule