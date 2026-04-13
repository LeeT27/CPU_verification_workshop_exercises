module top_module (
    input logic clk,
    input logic reset
);

    logic [31:0] pc, pc_next, instr;

    logic [31:0] rv1, rv2;
    logic [31:0] imm;
    logic [31:0] alu_in2, alu_result, mem_data, wb_data;

    logic reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch;
    logic zero;
    logic [3:0] alu_ctrl;

    // PC
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_out(pc)
    );

    // IMEM
    imem imem_inst (
        .addr(pc),
        .instr(instr)
    );

    // Register File
    regfile rf (
        .clk(clk),
        .write_ctrl(reg_write),
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd(instr[11:7]),
        .data(wb_data),
        .rv1(rv1),
        .rv2(rv2)
    );

    // Immediate Generator
    imm_gen immgen (
        .instr(instr),
        .imm(imm)
    );

    // Control Unit
    control_unit cu (
        .opcode(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7_5(instr[30]),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_ctrl(alu_ctrl)
    );

    // ALU input mux
    assign alu_in2 = alu_src ? imm : rv2;

    // ALU
    alu alu_inst (
        .a(rv1),
        .b(alu_in2),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );

    // Data Memory
    dmem dm (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(alu_result),
        .write_data(rv2),
        .read_data(mem_data)
    );

    // Writeback mux
    assign wb_data = mem_to_reg ? mem_data : alu_result;

    // PC logic (branch only simplified)
    assign pc_next = (branch && zero) ? (pc + imm) : (pc  );



endmodule