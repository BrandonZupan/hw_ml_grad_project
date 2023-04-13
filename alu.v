// alu.v

module alu (
    input [255:0]   op0_value;
    input [255:0]   op1_value;

    input [1:0]     mode;

    output [255:0]  alu_out;
);
    genvar i;

    generate 
        for (i = 0; i < 8; i = i + 1) begin
            // 8*i
            alu_8_bit alu0 (op0_value[(8*i) + 7, 8*i], op1_value[(8*i) + 7, 8*i], mode, alu_out[(8*i) + 7, 8*i]);
        end
    endgenerate

endmodule


module alu_8_bit (
    input [7:0] a, b, //8 bit inputs
    input [1:0] mode, //Select Operation
    output [7:0] z,
);
    wire [7:0] a,b;
    wire mode;
    case (mode)
        2'b01   ://And
            assign z = a & b;
        2'b10   ://Or
            assign z = a | b;
        2'b11   ://Xor
            assign z = a ^ b;
        default ://Add
            assign z = a + b;
    endcase
endmodule
