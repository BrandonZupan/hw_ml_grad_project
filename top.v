module TOP;

    reg [255:0] op0_value;
    reg [255:0] op1_value;

    reg [1:0] mode;

    wire [255:0] alu_out;

    alu uut (
        op0_value,
        op1_value,
        mode,
        alu_out
    );

    initial begin
        $display("============ \n Begin Test \n============");
        op0_value = 0;
        op1_value = 0;
        mode = 0;

        #10
        // Add 7 and 13
        op0_value = 7;
        op1_value = 13;
        mode = 0;

        #10
        $display("op0: %d\nop1: %d\nout: %d", op0_value, op1_value, alu_out);


        $display("==========\n End Test \n==========");

    end

    intitial #100 $finish;

    initial begin
        $vcdplusfile("name.dump.vpd");
        $vcdpluson(0, TOP);
    end


endmodule