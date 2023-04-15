
module alu_8_bit (
    input [7:0] a, b, //8 bit inputs
    input [1:0] mode, //Select Operation
    output reg [7:0] z
);
//     wire [7:0] a,b;
//     wire mode;

    always @(mode, a, b) begin
    case (mode)
        2'b01   ://And
            z = a & b;
        2'b10   ://Or
            z = a | b;
        2'b11   ://Xor
            z = a ^ b;
        default ://Add
            z = a + b;
    endcase
    end
endmodule
