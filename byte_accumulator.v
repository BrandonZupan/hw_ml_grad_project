// byte_accumulator.v

module byte_accumulator (
    input [31:0]    op0_value,
    output [7:0]    acc_out
);

    // Adds together the 4 8 bit values in op0 with adder tree
    assign acc_out = op0_value[31:24] + op0_value[23:16] + op0_value[15:8] + op0_value[7:0];

endmodule
