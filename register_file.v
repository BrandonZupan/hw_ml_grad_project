// register_file.v

module register_file (
    input           clk,
    input           reset,

    input [4:0]     op0_sel,
    input [4:0]     op1_sel,
    input [2:0]     vlmul,

    input [4:0]     wb_sel,
    input [255:0]   wb_in,
    input           wb_load,

    output [255:0]  op0_out,
    output [255:0]  op1_out,

    // for debug
    output [31:0] r0,
    output [31:0] r1,
    output [31:0] r2,
    output [31:0] r3,
    output [31:0] r4,
    output [31:0] r5,
    output [31:0] r6,
    output [31:0] r7,
    output [31:0] r8,
    output [31:0] r9,
    output [31:0] r10,
    output [31:0] r11,
    output [31:0] r12,
    output [31:0] r13,
    output [31:0] r14,
    output [31:0] r15,
    output [31:0] r16,
    output [31:0] r17,
    output [31:0] r18,
    output [31:0] r19,
    output [31:0] r20,
    output [31:0] r21,
    output [31:0] r22,
    output [31:0] r23,
    output [31:0] r24,
    output [31:0] r25,
    output [31:0] r26,
    output [31:0] r27,
    output [31:0] r28,
    output [31:0] r29,
    output [31:0] r30,
    output [31:0] r31

);

    wire [1023:0] registers_in;
    wire [1023:0] registers_out;

    // for debug
    assign r0 = registers_out[31:0];
    assign r1 = registers_out[63:32];
    assign r2 = registers_out[95:64];
    assign r3 = registers_out[127:96];
    assign r4 = registers_out[159:128];
    assign r5 = registers_out[191:160];
    assign r6 = registers_out[223:192];
    assign r7 = registers_out[255:224];
    assign r8 = registers_out[287:256];
    assign r9 = registers_out[319:288];
    assign r10 = registers_out[351:320];
    assign r11 = registers_out[383:352];
    assign r12 = registers_out[415:384];
    assign r13 = registers_out[447:416];
    assign r14 = registers_out[479:448];
    assign r15 = registers_out[511:480];
    assign r16 = registers_out[543:512];
    assign r17 = registers_out[575:544];
    assign r18 = registers_out[607:576];
    assign r19 = registers_out[639:608];
    assign r20 = registers_out[671:640];
    assign r21 = registers_out[703:672];
    assign r22 = registers_out[735:704];
    assign r23 = registers_out[767:736];
    assign r24 = registers_out[799:768];
    assign r25 = registers_out[831:800];
    assign r26 = registers_out[863:832];
    assign r27 = registers_out[895:864];
    assign r28 = registers_out[927:896];
    assign r29 = registers_out[959:928];
    assign r30 = registers_out[991:960];
    assign r31 = registers_out[1023:992];

    // Output selection
    register_out_select register_out_select0 (registers_out, op0_sel, vlmul, op0_out);
    register_out_select register_out_select1 (registers_out, op1_sel, vlmul, op1_out);

    wire [31:0] wb_reg_load;

    // wire [31:0] 
    // r0_in, r1_in, r2_in, r3_in,
    // r4_in, r5_in, r6_in, r7_in,
    // r8_in, r9_in, r10_in, r11_in,
    // r12_in, r13_in, r14_in, r15_in, 
    // r16_in, r17_in, r18_in, r19_in, 
    // r20_in, r21_in, r22_in, r23_in, 
    // r24_in, r25_in, r26_in, r27_in, 
    // r28_in, r29_in, r30_in, r31_in;

    // wire [1023:0] registers_in = {
    //     r31_in, r30_in, r29_in, r28_in,
    //     r27_in, r26_in, r25_in, r24_in,
    //     r23_in, r22_in, r21_in, r20_in,
    //     r19_in, r18_in, r17_in, r16_in,
    //     r15_in, r14_in, r13_in, r12_in,
    //     r11_in, r10_in, r9_in, r8_in,
    //     r7_in, r6_in, r5_in, r4_in,  
    //     r3_in, r2_in, r1_in, r0_in
    // };

    wire [1023:0] registers_in;


    // Set reg inputs
    wb_select wb_select0 (wb_load, wb_sel, vlmul, wb_reg_load);
    wb_align wb_align0 (wb_in, wb_sel, vlmul, registers_in);

    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            register_single register_single0 (clk, reset, wb_reg_load[i], registers_in[(i*32) + 31: i*32], registers_out[(i*32) + 31: i*32]);
        end
    endgenerate

endmodule
