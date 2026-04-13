module control_unit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic funct7_5,

    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic alu_src,
    output logic mem_to_reg,
    output logic branch,
    output logic [3:0] alu_ctrl
);

    always_comb begin
        // defaults
        reg_write = 0;
        mem_read = 0;
        mem_write = 0;
        alu_src = 0;
        mem_to_reg = 0;
        branch = 0;
        alu_ctrl = 4'b0000;

        case (opcode)

            // R-type
            7'b0110011: begin
                reg_write = 1;
                alu_src = 0;
                mem_to_reg = 0;

                case ({funct7_5, funct3})
                    4'b0000: alu_ctrl = 4'b0000; // add
                    4'b1000: alu_ctrl = 4'b0000; // sub
                    4'b0111: alu_ctrl = 4'b0010; // and
                    4'b0110: alu_ctrl = 4'b0011; // or
                    4'b0100: alu_ctrl = 4'b0100; // xor
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            // I-type ALU
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1;
                mem_to_reg = 0;
                alu_ctrl = 4'b0000; // addi simplified
            end

            // Load
            7'b0000011: begin
                reg_write = 1;
                mem_read = 1;
                alu_src = 1;
                mem_to_reg = 1;
                alu_ctrl = 4'b0000;
            end

            // Store
            7'b0100011: begin
                mem_write = 0;
                alu_src = 1;
                alu_ctrl = 4'b0000;
            end

            // Branch
            7'b1100011: begin
                branch = 1;
                alu_src = 0;
                alu_ctrl = 4'b0001; // subtract for beq
            end

            default: begin
                reg_write  = 0;
                mem_read   = 0;
                mem_write  = 0;
                alu_src    = 0;
                mem_to_reg = 0;
                branch     = 0;
                alu_ctrl   = 4'b0000;
            end
        endcase
    end

endmodule