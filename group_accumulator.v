// byte_accumulator.v

module group_accumulator (
    input [255:0]    op0_value,
    output [31:0]    gacc_out
);

    // Adds together the 8 32 bit values in op0 with adder tree
    
    // assign gacc_out = op0_value[255:224] + op0_value[223:192] + op0_value[191:160] + op0_value[159:128] + op0_value[127:96] + op0_value[95:64] + op0_value[63:32] + op0_value[31:0];

    wire [31:0] r0 = op0_value[31:0];
    wire [31:0] r1 = op0_value[63:32];
    wire [31:0] r2 = op0_value[95:64];
    wire [31:0] r3 = op0_value[127:96];
    wire [31:0] r4 = op0_value[159:128];
    wire [31:0] r5 = op0_value[191:160];
    wire [31:0] r6 = op0_value[223:192];
    wire [31:0] r7 = op0_value[255:224];

    assign gacc_out[7:0] = r0[7:0] + r0[15:8] + r0[23:16] + r0[31:24] + r4[7:0] + r4[15:8] + r4[23:16] + r4[31:24];
    assign gacc_out[15:8] = r1[7:0] + r1[15:8] + r1[23:16] + r1[31:24] + r5[7:0] + r5[15:8] + r5[23:16] + r5[31:24];
    assign gacc_out[23:16] = r2[7:0] + r2[15:8] + r2[23:16] + r2[31:24] + r6[7:0] + r6[15:8] + r6[23:16] + r6[31:24];
    assign gacc_out[31:24] = r3[7:0] + r3[15:8] + r3[23:16] + r3[31:24] + r7[7:0] + r7[15:8] + r7[23:16] + r7[31:24];

endmodule
