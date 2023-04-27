module decoder_unit (
    input    cmd_valid,
    input    [9:0]    cmd_payload_function_id,
    input    [31:0]   cmd_payload_inputs_0,
    input    [31:0]   cmd_payload_inputs_1,

    output reg [4:0]    reg_op0_sel, //register file controls
    output reg [4:0]    reg_op1_sel,
    output reg [4:0]    reg_wb_sel,
    output reg          reg_load,

    output reg [7:0]    alu_imm,
    output reg          alu_op1_sel,
    output reg [1:0]    alu_mode,

    output reg [1:0]    bus_sel,
    output reg          vl_load
);

    always @(*) begin

        // wire [];
        case (cmd_payload_function_id[2:0])
            3'h0 : begin //vsetvli
                vl_load=1;
                bus_sel=2'bXX;
                reg_op0_sel=5'hXX;
                reg_op1_sel=5'hXX;
                reg_wb_sel=5'hXX;
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
                reg_load=0;
            end
            3'h1 : begin //vload
                vl_load=0;
                reg_load=cmd_valid;
                bus_sel=2'b00;//Take care of in core file
                reg_wb_sel=cmd_payload_function_id[7:3];
                reg_op0_sel=5'hXX;
                reg_op1_sel=5'hXX;
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
            end
            3'h2 : begin //vadd.vector - immediate
                vl_load=0;
                reg_load=cmd_valid;
                bus_sel=2'b01;
                reg_wb_sel=cmd_payload_function_id[7:3];
                reg_op0_sel=cmd_payload_inputs_0[4:0];
                reg_op1_sel=5'hXX;
                alu_imm=cmd_payload_inputs_0[7:0];
                alu_op1_sel=1;
                alu_mode=2'bXX;
            end
            3'h3 : begin //vacc - group add
                vl_load=0;
                reg_load=cmd_valid;
                bus_sel=00;
                reg_wb_sel=cmd_payload_function_id[7:3];
                reg_op0_sel=cmd_payload_inputs_0[4:0];
                reg_op1_sel=5'hXX;
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
            end
            3'h4 : begin //vmul
                vl_load=0;
                reg_load=cmd_valid;
                bus_sel=2'b10;
                reg_wb_sel=cmd_payload_function_id[7:3];
                reg_op0_sel=cmd_payload_inputs_0[4:0];
                reg_op1_sel=cmd_payload_inputs_1[4:0];
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
            end
            3'h5 : begin //vbacc - byte add
                vl_load=0;
                reg_load=0;
                bus_sel=2'b11;
                reg_wb_sel=5'hXX;
                reg_op0_sel=cmd_payload_function_id[7:3];
                reg_op1_sel=5'hXX;
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
            end
            default : begin
                vl_load=0;
                bus_sel=2'bXX;
                reg_op0_sel=5'hXX;
                reg_op1_sel=5'hXX;
                reg_wb_sel=5'hXX;
                alu_imm=8'hXX;
                alu_op1_sel=1'bX;
                alu_mode=2'bXX;
                reg_load=0;
            end
        endcase
    end
endmodule