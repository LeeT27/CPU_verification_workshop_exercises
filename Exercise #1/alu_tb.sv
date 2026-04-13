// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module alu_tb;
    // Signals
    logic [31:0] a, b;
    logic [2:0] alu_ctrl;
    logic [31:0] result;

    // Instantiate DUT
    alu dut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result)
    );

    initial begin // Initialize
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
        //START WRITING CODE HERE

        a = ;
        b = ;
        alu_ctrl = ;
        #10; // 10ns delay 

        
        //Repeat the above lines for every signal change

        $finish; // End simulation
    end

endmodule