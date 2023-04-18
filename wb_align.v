module wb_align (
    input [255:0]   wb_in,
    input [4:0]     wb_sel,

    input [2:0]     vlmul,

    output reg [1023:0] registers
);

    always @(*) begin
        case (vlmul)
            3'b000:     // write to one register
                registers = {992'b0, wb_in[31:0]} << (wb_sel * 32);
            3'b001:     // 2 registers
                registers = {960'b0, wb_in[63:0]} << (wb_sel * 32 * 2);
            3'b010:     // 4 registers
                registers = {896'b0, wb_in[127:0]} << (wb_sel * 32 * 4);
            3'b011:
                registers = {768'b0, wb_in[255:0]} << (wb_sel * 32 * 8);
            default:
                registers = 0;
        endcase
    end

endmodule
