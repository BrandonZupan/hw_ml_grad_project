// multiply.v

module multiply (
    input [255:0]   op0_value,
    input [255:0]   op1_value,

    input [2:0]     vlmul,

    output reg [255:0]  mul_out
);

    wire [255:0] block_outs;

    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            multiply_8_bit mul0 (op0_value[(8*i) + 7: 8*i], op1_value[(8*i) + 7: 8*i], block_outs[(8*i) + 7: 8*i]);
        end
    
    endgenerate

    // mux for determining output
    always @(vlmul, block_outs) begin
        case (vlmul)
            3'b000:     // 1 register
                mul_out = {224'b0, block_outs[31:0]};
            3'b001:     // 2 registers
                mul_out = {192'b0, block_outs[63:0]};
            3'b010:     // 4 registers
                mul_out = {128'b0, block_outs[127:0]};
            3'b011:     // 8 registers
                mul_out = block_outs;
            default:
                mul_out = 0;
        endcase

    end



endmodule
