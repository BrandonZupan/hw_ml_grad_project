// alu.v

module alu (
    input [255:0]   op0_value;
    input [255:0]   op1_value;

    input [1:0]     mode;

    output [255:0]  alu_out;
);

endmodule