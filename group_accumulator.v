// byte_accumulator.v

module group_accumulator (
    input [255:0]    op0_value,
    output [31:0]    gacc_out
);

    // Adds together the 8 32 bit values in op0 with adder tree
    
    assign gacc_out = op0_value[255:224] + op0_value[223:192] + op0_value[191:160] + op0_value[159:128] + op0_value[127:96] + op0_value[95:64] + op0_value[63:32] + op0_value[31:0];

endmodule
