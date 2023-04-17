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

    output reg [255:0]  op0_out,
    output reg [255:0]  op1_out

);

    reg [31:0] 
    r0, r1, r2, r3,
    r4, r5, r6, r7,
    r8, r9, r10, r11,
    r12, r13, r14, r15, 
    r16, r17, r18, r19, 
    r20, r21, r22, r23, 
    r24, r25, r26, r27, 
    r28, r29, r30, r31;

    wire [1023:0] registers = {
        r31, r30, r29, r28,
        r27, r26, r25, r24,
        r23, r22, r21, r20,
        r19, r18, r17, r16,
        r15, r14, r13, r12,
        r11, r10, r9, r8,
        r7, r6, r5, r4,  
        r3, r2, r1, r0
    };

    // Output selection
    register_out_select register_out_select0 (registers, op0_sel, vlmul, op0_out);
    register_out_select register_out_select1 (registers, op1_sel, vlmul, op1_out);

    wire [31:0] wb_reg_load;

    wire [31:0] 
    r0_in, r1_in, r2_in, r3_in,
    r4_in, r5_in, r6_in, r7_in,
    r8_in, r9_in, r10_in, r11_in,
    r12_in, r13_in, r14_in, r15_in, 
    r16_in, r17_in, r18_in, r19_in, 
    r20_in, r21_in, r22_in, r23_in, 
    r24_in, r25_in, r26_in, r27_in, 
    r28_in, r29_in, r30_in, r31_in;

    wire [1023:0] registers_in = {
        r31_in, r30_in, r29_in, r28_in,
        r27_in, r26_in, r25_in, r24_in,
        r23_in, r22_in, r21_in, r20_in,
        r19_in, r18_in, r17_in, r16_in,
        r15_in, r14_in, r13_in, r12_in,
        r11_in, r10_in, r9_in, r8_in,
        r7_in, r6_in, r5_in, r4_in,  
        r3_in, r2_in, r1_in, r0_in
    };


    // Set reg inputs
    wb_select wb_select0 (wb_load, wb_sel, vlmul, wb_reg_load);
    wb_align wb_align0 (wb_in, wb_sel, vlmul, registers_in);

    // Writeback
    always @(clk, reset, wb_load) begin
        if (reset) begin
            r0 <= 0;
            r1 <= 0;
            r2 <= 0;
            r3 <= 0;
            r4 <= 0;
            r5 <= 0;
            r6 <= 0;
            r7 <= 0;
            r8 <= 0;
            r9 <= 0;
            r10 <= 0;
            r11 <= 0;
            r12 <= 0;
            r13 <= 0;
            r14 <= 0;
            r15 <= 0;
            r16 <= 0;
            r17 <= 0;
            r18 <= 0;
            r19 <= 0;
            r20 <= 0;
            r21 <= 0;
            r22 <= 0;
            r23 <= 0;
            r24 <= 0;
            r25 <= 0;
            r26 <= 0;
            r27 <= 0;
            r28 <= 0;
            r29 <= 0;
            r30 <= 0;
            r31 <= 0;
        end else begin
            if (wb_reg_load[0])
                r0 = r0_in;
            if (wb_reg_load[1])
                r1 = r1_in;
            if (wb_reg_load[2])
                r2 = r2_in;
            if (wb_reg_load[3])
                r3 = r3_in;
            if (wb_reg_load[4])
                r4 = r4_in;
            if (wb_reg_load[5])
                r5 = r5_in;
            if (wb_reg_load[6])
                r6 = r6_in;
            if (wb_reg_load[7])
                r7 = r7_in;
            if (wb_reg_load[8])
                r8 = r8_in;
            if (wb_reg_load[9])
                r9 = r9_in;
            if (wb_reg_load[10])
                r10 = r10_in;
            if (wb_reg_load[11])
                r11 = r11_in;
            if (wb_reg_load[12])
                r12 = r12_in;
            if (wb_reg_load[13])
                r13 = r13_in;
            if (wb_reg_load[14])
                r14 = r14_in;
            if (wb_reg_load[15])
                r15 = r15_in;
            if (wb_reg_load[16])
                r16 = r16_in;
            if (wb_reg_load[17])
                r17 = r17_in;
            if (wb_reg_load[18])
                r18 = r18_in;
            if (wb_reg_load[19])
                r19 = r19_in;
            if (wb_reg_load[20])
                r20 = r20_in;
            if (wb_reg_load[21])
                r21 = r21_in;
            if (wb_reg_load[22])
                r22 = r22_in;
            if (wb_reg_load[23])
                r23 = r23_in;
            if (wb_reg_load[24])
                r24 = r24_in;
            if (wb_reg_load[25])
                r25 = r25_in;
            if (wb_reg_load[26])
                r26 = r26_in;
            if (wb_reg_load[27])
                r27 = r27_in;
            if (wb_reg_load[28])
                r28 = r28_in;
            if (wb_reg_load[29])
                r29 = r29_in;
            if (wb_reg_load[30])
                r30 = r30_in;
            if (wb_reg_load[31])
                r31 = r31_in;
            
        end
    end



endmodule