module dmem (
    input  logic clk,
    input  logic mem_write,
    input  logic mem_read,
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

    logic [31:0] mem [0:1023];

    always_ff @(posedge clk) begin
        if (mem_write)
            mem[addr[11:2]] <= write_data;
    end
    initial begin
        mem[1] = 10;
        mem[2] = 99;
        mem[3] = 22;
        mem[4] = 57;
    end

    assign read_data = mem_read ? mem[addr[11:2]] : 32'b0;

endmodule