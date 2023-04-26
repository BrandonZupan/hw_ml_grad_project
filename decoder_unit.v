module decoder_block(
    input    cmd_valid,
    input    [9:0]    cmd_payload_function_id,
    input    [31:0]   cmd_payload_inputs_0,
    input    [31:0]   cmd_payload_inputs_1,

    output reg  [4:0]    reg_op0_sel, //register file controls
    output reg  [4:0]    reg_op1_sel,
    output reg  [4:0]    reg_wb_sel,
    output reg           reg_load,

    output reg  [7:0]    alu_imm,
    output reg           alu_op1_sel,
    output reg  [1:0]    alu_mode,

    output reg  [1:0]    bus_sel,
    output reg           vl_load
);

    always @(*) begin
    // wire [];
    case (cmd_payload_function_id[9:5])
        5'h17 : begin //vsetvli
            assign vl_load = 1;
            assign bus_sel = 2'bXX;
            assign reg_op0_sel=5'hXX;
            assign reg_op1_sel=5'hXX;
            assign reg_wb_sel=5'hXX;
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
            assign reg_load=0;
        end
        5'h07 : begin //vload
            assign vl_load=0;
            assign reg_load=cmd_valid;
            assign bus_sel=2'b00;   //Take care of in core file
            assign reg_wb_sel=cmd_payload_function_id[4:0];
            assign reg_op0_sel=5'hXX;
            assign reg_op1_sel=5'hXX;
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
        end
        5'h15 : begin   //vadd.vector - immediate
            assign vl_load=0;
            assign reg_load=cmd_valid;
            assign bus_sel=2'b01;
            assign reg_wb_sel=cmd_payload_function_id[4:0];
            assign reg_op0_sel=cmd_payload_inputs_0[4:0];
            assign reg_op1_sel=5'hXX;
            assign alu_imm=cmd_payload_inputs_1[7:0];
            assign alu_op1_sel=1;
            assign alu_mode=2'bXX;
        end

        5'h0D : begin //vacc - group add
            assign vl_load=0;
            assign reg_load=cmd_valid;
            assign bus_sel=00;
            assign reg_wb_sel=cmd_payload_function_id[4:0];
            assign reg_op0_sel=cmd_payload_inputs_0[4:0];
            assign reg_op1_sel=5'hXX;
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
        end
        5'h04 : begin //vmul
            assign vl_load=0;
            assign reg_load=cmd_valid;
            assign bus_sel=2'b10;
            assign reg_wb_sel=cmd_payload_function_id[4:0];
            assign reg_op0_sel=cmd_payload_inputs_0[4:0];
            assign reg_op1_sel=cmd_payload_inputs_1[4:0];
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
        end
        5'h1D : begin   //vbacc - byte add
            assign vl_load=0;
            assign reg_load=0;
            assign bus_sel=2'b11;
            assign reg_wb_sel=cmd_payload_function_id[4:0];
            assign reg_op0_sel=5'hXX;
            assign reg_op1_sel=5'hXX;
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
        end
        default: begin
            assign vl_load = 0;
            assign bus_sel = 2'bXX;
            assign reg_op0_sel=5'hXX;
            assign reg_op1_sel=5'hXX;
            assign reg_wb_sel=5'hXX;
            assign alu_imm=8'hXX;
            assign alu_op1_sel=1'bX;
            assign alu_mode=2'bXX;
            assign reg_load=0;
        end
    endcase
    end
endmodule