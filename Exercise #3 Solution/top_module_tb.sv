`timescale 1ns/1ps

module top_module_tb;

    logic clk;
    logic reset;

    // DUT
    top_module dut (
        .clk(clk),
        .reset(reset)
    );

    // -------------------------
    // CLOCK
    // -------------------------
    initial clk = 0;
    always #10 clk = ~clk;

    // -------------------------
    // WAVEFORM DUMP
    // -------------------------
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, top_module_tb);
    end

    // -------------------------
    // RESET + RUN
    // -------------------------
    initial begin
        reset = 1;

        repeat (2) @(posedge clk);
        reset = 0;

        repeat (50) @(posedge clk);

        // FINAL RESULT ONLY
        $display("mem[1] = %0d", dut.dm.mem[1]);

        $finish;
    end

endmodule