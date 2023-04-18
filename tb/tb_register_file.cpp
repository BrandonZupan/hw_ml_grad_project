// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vregister_file.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vregister_file *dut, vluint64_t &sim_time){
    dut->reset = 0;
    if(sim_time >= 3 && sim_time < 6){
        dut->reset = 1;
    }
}

void dut_print_registers(Vregister_file *dut) {
    printf("R0: 0x%08X, %d\n", dut->r0, dut->r0);
    printf("R1: 0x%08X, %d\n", dut->r1, dut->r1);
    printf("R2: 0x%08X, %d\n", dut->r2, dut->r2);
    printf("R3: 0x%08X, %d\n", dut->r3, dut->r3);
    printf("R4: 0x%08X, %d\n", dut->r4, dut->r4);
    printf("R5: 0x%08X, %d\n", dut->r5, dut->r5);
    printf("R6: 0x%08X, %d\n", dut->r6, dut->r6);
    printf("R7: 0x%08X, %d\n", dut->r7, dut->r7);
    printf("R8: 0x%08X, %d\n", dut->r8, dut->r8);
    printf("R9: 0x%08X, %d\n", dut->r9, dut->r9);
    printf("R10: 0x%08X, %d\n", dut->r10, dut->r10);
    printf("R11: 0x%08X, %d\n", dut->r11, dut->r11);
    printf("R12: 0x%08X, %d\n", dut->r12, dut->r12);
    printf("R13: 0x%08X, %d\n", dut->r13, dut->r13);
    printf("R14: 0x%08X, %d\n", dut->r14, dut->r14);
    printf("R15: 0x%08X, %d\n", dut->r15, dut->r15);
    printf("R16: 0x%08X, %d\n", dut->r16, dut->r16);
    printf("R17: 0x%08X, %d\n", dut->r17, dut->r17);
    printf("R18: 0x%08X, %d\n", dut->r18, dut->r18);
    printf("R19: 0x%08X, %d\n", dut->r19, dut->r19);
    printf("R20: 0x%08X, %d\n", dut->r20, dut->r20);
    printf("R21: 0x%08X, %d\n", dut->r21, dut->r21);
    printf("R22: 0x%08X, %d\n", dut->r22, dut->r22);
    printf("R23: 0x%08X, %d\n", dut->r23, dut->r23);
    printf("R24: 0x%08X, %d\n", dut->r24, dut->r24);
    printf("R25: 0x%08X, %d\n", dut->r25, dut->r25);
    printf("R26: 0x%08X, %d\n", dut->r26, dut->r26);
    printf("R27: 0x%08X, %d\n", dut->r27, dut->r27);
    printf("R28: 0x%08X, %d\n", dut->r28, dut->r28);
    printf("R29: 0x%08X, %d\n", dut->r29, dut->r29);
    printf("R30: 0x%08X, %d\n", dut->r30, dut->r30);
    printf("R31: 0x%08X, %d\n", dut->r31, dut->r31);
}

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vregister_file *dut = new Vregister_file;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    int reg_number = 0;
    while (sim_time < MAX_SIM_TIME) {
        dut_reset(dut, sim_time);

        dut->clk ^= 1;
        dut->eval();

        if (dut->clk == 1){
            posedge_cnt++;

            // Check previous outputs

            // Set new inputs
            // dut->vlmul = 0;
            // dut->wb_sel = reg_number;
            // dut->wb_in[0] = reg_number;
            // dut->wb_load = 1;
            // reg_number++;
            dut->wb_sel = 31;
            dut->vlmul = 0;
            dut->wb_in[0] = 1234;
            dut->wb_load = 1;

        }

        m_trace->dump(sim_time);
        sim_time++;

        if (reg_number >= 32) {
            break;
        }
    }
    dut_print_registers(dut);

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
