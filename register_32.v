module register_single (
    input           clk,
    input           reset,
    input           enable,
    input [WIDTH:0]    in,

    output [WIDTH:0]   out
);
    parameter WIDTH = 32;

    reg [WIDTH:0] r;

    always @(clk, reset, enable) begin
        if (reset)
            r <= 0;
        else if (enable)
            r <= in;
    end


endmodule