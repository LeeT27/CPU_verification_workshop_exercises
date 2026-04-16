`timescale 1ns/1ps

module regfile_tb;
    // Signals
    logic clk;
    logic write_ctrl;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] data;
    logic [31:0] rv1, rv2;

    task automatic read_regfile (
        input logic [4:0] rs1_s,
        input logic [31:0] rs1_v,
        input logic [4:0] rs2_s,
        input logic [31:0] rs2_v
    );
        rs1 = rs1_s;
        rs2 = rs2_s;
        #10;
        assert (rv1 == rs1_v)
            else $error("Read RS1 failed: Expected = %0x Actual = %0x", rs1_v, rv1);
        assert (rv2 == rs2_v)
            else $error("Read RS2 failed: Expected = %0x Actual = %0x", rs2_v, rv2);
    endtask

    task automatic write_regfile (
        input logic [4:0] rd_s,
        input logic [31:0] rd_v
    );
        write_ctrl = 1'b1;
        rd = rd_s;
        data = rd_v;
        #10;
    endtask

    // Instantiate DUT
    regfile dut (
        .clk(clk),
        .write_ctrl(write_ctrl),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .data(data),
        .rv1(rv1),
        .rv2(rv2)
    );

    initial begin : clock_initial
        clk = 0;
    end
    // Clock (10 time unit period)
    always begin : clock_generation
        #5 clk = ~clk;
    end

    initial begin  : test_vectors // Initialize 
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);
        // Initialize signals
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        data = 0;
        write_ctrl = 0;

        read_regfile(5'd0, 32'd0, 5'd0, 32'd0);

        @(posedge clk);
        write_regfile(5'd1, 32'd12);
        write_ctrl = 0;

        @(posedge clk);
        write_regfile(5'd3, 32'd5);
        write_ctrl = 0;

        read_regfile(5'd1, 32'd12, 5'd3, 32'd5); //Try changing the second argument to 13

        // Done
        $finish; // End simulation
    end

endmodule