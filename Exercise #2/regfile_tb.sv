`timescale 1ns/1ps

module regfile_tb;
    // Signals
    logic clk;
    logic write_ctrl;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] data;
    logic [31:0] rv1, rv2;

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
    always #5 clk = ~clk;

    initial begin // Initialize 
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);
        //START HERE
        

        // END HERE
        $finish; // End simulation
    end

endmodule