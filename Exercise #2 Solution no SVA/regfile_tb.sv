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

    // Clock (10 time unit period)
    always #5 clk = ~clk;

    initial begin // Initialize 
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);
        clk = 0;
        //START WRITING CODE HERE
        
        write_ctrl = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        data = 0;
        #10; // 10ns delay 
        write_ctrl = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 1;
        data = 12;
        #10; // 10ns delay 
        write_ctrl = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 3;
        data = 5;
        #10; // 10ns delay 
        write_ctrl = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 3;
        data = 2;
        #10; // 10ns delay 
        write_ctrl = 0;
        rs1 = 1;
        rs2 = 3;
        rd = 0;
        data = 0;
        #10; // 10ns delay 

        //Repeat the above lines for every signal change



        $finish; // End simulation
    end

endmodule