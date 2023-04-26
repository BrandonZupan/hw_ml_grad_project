module decoder_block(
    input    cmd_valid,
    input    [9:0]    cmd_payload_function_id,
    input    [31:0]   cmd_payload_inputs_0,
    input    [31:0]   cmd_payload_inputs_1,

    output  [4:0]    reg_op0_sel, //register file controls
    output  [4:0]    reg_op1_sel,
    output  [4:0]    reg_wb_sel,
    output           reg_load,

    output  [7:0]    alu_imm,
    output           alu_op1_sel,
    output  [1:0]    alu_mode,

    output  [1:0]    bus_sel,
    output           vl_load,
);
    // wire [];
    case (cmd_payload_function_id[2:0])
        3'h0     ://vsetvli
            vl_load=1;
            bus_sel=2bXX;
            reg_op0_sel=5hXX;
            reg_op1_sel=5hXX;
            reg_wb_sel=5hXX;
            alu_imm=8hXX;
            alu_op1_sel=X;
            alu_mode=2bXX;
            reg_load=0;
        3'h1     ://vload
            vl_load=0;
            reg_load=cmd_valid;
            bus_sel=2b00;//Take care of in core file
            reg_wb_sel=cmd_payload_function_id[7:3];
            reg_op0_sel=5hXX;
            reg_op1_sel=5hXX;
            alu_imm=8hXX;
            alu_op1_sel=X;
            alu_mode=2bXX;
        3'h2     ://vadd.vector - immediate
            vl_load=0;
            reg_load=cmd_valid;
            bus_sel=2b01;
            reg_wb_sel=cmd_payload_function_id[7:3];
            reg_op0_sel=cmd_payload_inputs_0[4:0];
            reg_op1_sel=8hXX;
            alu_imm=cmd_payload_inputs_0[7:0];
            alu_op1_sel=1;
            alu_mode=2bXX;

        3'h3     ://vacc - group add
            vl_load=0;
            reg_load=cmd_valid;
            bus_sel=00;
            reg_wb_sel=cmd_payload_function_id[7:3];
            reg_op0_sel=cmd_payload_inputs_0[4:0];
            reg_op1_sel=5hXX;
            alu_imm=8hXX;
            alu_op1_sel=X;
            alu_mode=2bXX;
        3'h4     ://vmul
            vl_load=0;
            reg_load=cmd_valid;
            bus_sel=2b10;
            reg_wb_sel=cmd_payload_function_id[7:3];
            reg_op0_sel=cmd_payload_inputs_0[4:0];
            reg_op1_sel=cmd_payload_inputs_1[4:0];
            alu_imm=8hXX;
            alu_op1_sel=X;
            alu_mode=2bXX;
        3'h5     ://vbacc - byte add
            vl_load=0;
            reg_load=0;
            bus_sel=2b11;
            reg_wb_sel=5hXX;
            reg_op0_sel=cmd_payload_function_id[7:3];
            reg_op1_sel=5hXX;
            alu_imm=8hXX;
            alu_op1_sel=X;
            alu_mode=2bXX;

    endcase
endmodule