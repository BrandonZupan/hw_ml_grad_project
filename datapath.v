// datapath.v
// Used to test components without decode to verify they all work together

module datapath (
    input clk,
    input reset,

    input [2:0] vlmul,

    input [4:0] op0_sel,
    input [4:0] op1_sel,
    input [4:0] wb_sel,
    // input [255:0] wb_in,
    input wb_load,

    output [31:0] r0,
    output [31:0] r1,
    output [31:0] r2,
    output [31:0] r3,
    output [31:0] r4,
    output [31:0] r5,
    output [31:0] r6,
    output [31:0] r7,
    output [31:0] r8,
    output [31:0] r9,
    output [31:0] r10,
    output [31:0] r11,
    output [31:0] r12,
    output [31:0] r13,
    output [31:0] r14,
    output [31:0] r15,
    output [31:0] r16,
    output [31:0] r17,
    output [31:0] r18,
    output [31:0] r19,
    output [31:0] r20,
    output [31:0] r21,
    output [31:0] r22,
    output [31:0] r23,
    output [31:0] r24,
    output [31:0] r25,
    output [31:0] r26,
    output [31:0] r27,
    output [31:0] r28,
    output [31:0] r29,
    output [31:0] r30,
    output [31:0] r31,

    input [7:0] alu_imm,
    input alu_op1_sel,
    input [1:0] alu_mode,

    output [255:0] bus_out
    
);

wire [255:0] op0_out;
wire [255:0] op1_out;

wire [255:0] BUS;

assign bus_out = BUS;

register_file rf0 (
    clk,
    reset,
    op0_sel,
    op1_sel,
    vlmul,
    wb_sel,
    BUS,
    wb_load,
    op0_out,
    op1_out,
    r0,
    r1,
    r2,
    r3,
    r4,
    r5,
    r6,
    r7,
    r8,
    r9,
    r10,
    r11,
    r12,
    r13,
    r14,
    r15,
    r16,
    r17,
    r18,
    r19,
    r20,
    r21,
    r22,
    r23,
    r24,
    r25,
    r26,
    r27,
    r28,
    r29,
    r30,
    r31
);

wire [255:0] alu_imm_padded;

genvar i;
generate 
for (i = 0; i < 32; i = i + 1) begin
    assign alu_imm_padded[(i*8)+7 : i*8] = alu_imm;
end
endgenerate

// mux selecting op1
wire [255:0] alu_op1_in = alu_op1_sel ? alu_imm_padded : op1_out;
wire [255:0] alu_out;

alu alu0 (
    op0_out,
    alu_op1_in,
    alu_mode,
    alu_out
);

assign BUS = alu_out;


endmodule
