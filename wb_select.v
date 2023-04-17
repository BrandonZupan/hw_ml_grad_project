module wb_select (
    input       wb_load,
    input [5:0] wb_sel,
    input [2:0] vlmul,
    
    output [31:0]   wb_reg_load     // load enable for each reg. 0, 1, 2, 4, or 8 will be active

);

    // mux selecting which decoder output to use

    reg [31:0] wb_reg_decoded;

    always @(*) begin
        case (vlmul)
            3'b000:     // enable 1 register
                // write to one register based on wb_sel
                wb_reg_decoded = 32'h0000_0001 << wb_sel;
            3'b001:     // enable 2 registers
                wb_reg_decoded = 32'h0000_0003 << (wb_sel[5:1] * 2);
            3'b010:     // enable 4 registers
                wb_reg_decoded = 32'h0000_000F << (wb_sel[5:2] * 4);
            3'b011:     // enable 8 registers
                wb_reg_decoded = 32'h0000_00FF << (wb_sel[5:3] * 8);
            default:
                wb_reg_decoded = 0;
        endcase
    end

    genvar i;
    generate 
        for (i = 0; i < 32; i++)  begin
            assign wb_reg_load[i] = wb_reg_decoded[i] & wb_load;
        end
    endgenerate

endmodule
