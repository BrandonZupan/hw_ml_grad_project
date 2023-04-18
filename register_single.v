module register_single (
    input           clk,
    input           reset,
    input           enable,
    input [WIDTH-1:0]    in,

    output [WIDTH-1:0]   out
);
    parameter WIDTH = 32;

    reg [WIDTH-1:0] r;

    assign out = r;

    always @(posedge clk, reset) begin
        if (reset)
            r <= 0;
        else if (enable)
            r <= in;
    end


endmodule
