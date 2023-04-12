// register_file.v

module register_file (
    input           clk;
    input           reset;

    input [4:0]     op0_sel;
    input [4:0]     op1_sel;
    input [31:0]    vtype;
    input [5:0]     vlen;

    input [4:0]     wb_sel;
    input [255:0]   wb_in;
    input           wb_load;

    output [255:0]  op0_out;
    output [255:0]  op1_out;

);

endmodule