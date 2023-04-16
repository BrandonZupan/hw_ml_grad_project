module register_out_select (
    input [1023:0]   registers,
    input [4:0]     op0_sel,
    input [2:0]     vlmul,

    output reg [255:0] op0_out 
);

    wire [31:0] r0 = registers[31:0];
    wire [31:0] r1 = registers[63:32];
    wire [31:0] r2 = registers[95:64];
    wire [31:0] r3 = registers[127:96];
    wire [31:0] r4 = registers[159:128];
    wire [31:0] r5 = registers[191:160];
    wire [31:0] r6 = registers[223:192];
    wire [31:0] r7 = registers[255:224];
    wire [31:0] r8 = registers[287:256];
    wire [31:0] r9 = registers[319:288];
    wire [31:0] r10 = registers[351:320];
    wire [31:0] r11 = registers[383:352];
    wire [31:0] r12 = registers[415:384];
    wire [31:0] r13 = registers[447:416];
    wire [31:0] r14 = registers[479:448];
    wire [31:0] r15 = registers[511:480];
    wire [31:0] r16 = registers[543:512];
    wire [31:0] r17 = registers[575:544];
    wire [31:0] r18 = registers[607:576];
    wire [31:0] r19 = registers[639:608];
    wire [31:0] r20 = registers[671:640];
    wire [31:0] r21 = registers[703:672];
    wire [31:0] r22 = registers[735:704];
    wire [31:0] r23 = registers[767:736];
    wire [31:0] r24 = registers[799:768];
    wire [31:0] r25 = registers[831:800];
    wire [31:0] r26 = registers[863:832];
    wire [31:0] r27 = registers[895:864];
    wire [31:0] r28 = registers[927:896];
    wire [31:0] r29 = registers[959:928];
    wire [31:0] r30 = registers[991:960];
    wire [31:0] r31 = registers[1023:992];
    

    // Register Access
    
    // Accesses must be aligned to simplify
    // First put the 8 registers onto a wire
    // Use a mux to select what output is

    reg [255:0] op0_8_selected_regs_out;
    wire [1:0] op0_8_group_select = op0_sel[4:3];

    always @(*) begin
        case (op0_8_group_select)
            2'b00:  // r0-r7
                op0_8_selected_regs_out = {r7, r6, r5, r4, r3, r2, r1, r0};
            2'b01:  // r8-r15
                op0_8_selected_regs_out = {r15, r14, r13, r12, r11, r10, r9, r8};
            2'b10:  // r16-r23
                op0_8_selected_regs_out = {r23, r22, r21, r20, r19, r18, r17, r16};
            2'b11:  //r24-r31
                op0_8_selected_regs_out = {r31, r30, r29, r28, r27, r26, r25, r24};
        endcase
    end

    reg [127:0] op0_4_selected_regs_out;
    wire [2:0] op0_4_group_select = op0_sel[4:2];

    always @(*) begin
        case (op0_4_group_select)
            3'b000:
                op0_4_selected_regs_out = {r3, r2, r1, r0};
            3'b001:
                op0_4_selected_regs_out = {r7, r6, r5, r4};
            3'b010:
                op0_4_selected_regs_out = {r11, r10, r9, r8};
            3'b011:
                op0_4_selected_regs_out = {r15, r14, r13, r12};
            3'b100:
                op0_4_selected_regs_out = {r19, r18, r17, r16};
            3'b101:
                op0_4_selected_regs_out = {r23, r22, r21, r20};
            3'b110:
                op0_4_selected_regs_out = {r27, r26, r25, r24};
            3'b111:
                op0_4_selected_regs_out = {r31, r30, r29, r28};
        endcase
    end

    reg [63:0]  op0_2_selected_regs_out;
    wire [3:0] op0_2_group_selected = op0_sel[4:1];

    always @(*) begin
        case (op0_2_group_selected)
            4'b0000:
                op0_2_selected_regs_out = {r1, r0};
            4'b0001:
                op0_2_selected_regs_out = {r3, r2};
            4'b0010:
                op0_2_selected_regs_out = {r5, r4};
            4'b0011:
                op0_2_selected_regs_out = {r7, r6};
            4'b0100:
                op0_2_selected_regs_out = {r9, r8};
            4'b0101:
                op0_2_selected_regs_out = {r11, r10};
            4'b0110:
                op0_2_selected_regs_out = {r13, r12};
            4'b0111:
                op0_2_selected_regs_out = {r15, r14};
            4'b1000:
                op0_2_selected_regs_out = {r17, r16};
            4'b1001:
                op0_2_selected_regs_out = {r19, r18};
            4'b1010:
                op0_2_selected_regs_out = {r21, r20};
            4'b1011:
                op0_2_selected_regs_out = {r23, r22};
            4'b1100:
                op0_2_selected_regs_out = {r25, r24};
            4'b1101:
                op0_2_selected_regs_out = {r27, r26};
            4'b1110:
                op0_2_selected_regs_out = {r29, r28};
            4'b1111:
                op0_2_selected_regs_out = {r31, r30};
        endcase
    end

    // no group select since its just the selection
    reg [31:0] op0_1_selected_regs_out;

    always @(*) begin
        case (op0_sel)
            0: op0_1_selected_regs_out = r0;
            1: op0_1_selected_regs_out = r1;
            2: op0_1_selected_regs_out = r2;
            3: op0_1_selected_regs_out = r3;
            4: op0_1_selected_regs_out = r4;
            5: op0_1_selected_regs_out = r5;
            6: op0_1_selected_regs_out = r6;
            7: op0_1_selected_regs_out = r7;
            8: op0_1_selected_regs_out = r8;
            9: op0_1_selected_regs_out = r9;
            10: op0_1_selected_regs_out = r10;
            11: op0_1_selected_regs_out = r11;
            12: op0_1_selected_regs_out = r12;
            13: op0_1_selected_regs_out = r13;
            14: op0_1_selected_regs_out = r14;
            15: op0_1_selected_regs_out = r15;
            16: op0_1_selected_regs_out = r16;
            17: op0_1_selected_regs_out = r17;
            18: op0_1_selected_regs_out = r18;
            19: op0_1_selected_regs_out = r19;
            20: op0_1_selected_regs_out = r20;
            21: op0_1_selected_regs_out = r21;
            22: op0_1_selected_regs_out = r22;
            23: op0_1_selected_regs_out = r23;
            24: op0_1_selected_regs_out = r24;
            25: op0_1_selected_regs_out = r25;
            26: op0_1_selected_regs_out = r26;
            27: op0_1_selected_regs_out = r27;
            28: op0_1_selected_regs_out = r28;
            29: op0_1_selected_regs_out = r29;
            30: op0_1_selected_regs_out = r30;
            31: op0_1_selected_regs_out = r31;
        endcase
    end

    // select op0_out based on vlen
    always @(*) begin
        case (vlmul)
            3'b000:     // 1 reg
                op0_out = {224'b0, op0_1_selected_regs_out};
            3'b001:     // 2 reg
                op0_out = {192'b0, op0_2_selected_regs_out};
            3'b010:
                op0_out = {128'b0, op0_4_selected_regs_out};
            3'b011:
                op0_out = op0_8_selected_regs_out;
            default:
                op0_out = 0;
        endcase
    end

endmodule
