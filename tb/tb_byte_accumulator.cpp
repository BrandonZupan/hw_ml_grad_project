// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vbyte_accumulator.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vbyte_accumulator *dut, vluint64_t &sim_time){
    // dut->rst = 0;
    // if(sim_time >= 3 && sim_time < 6){
    //     dut->rst = 1;
    //     dut->a_in = 0;
    //     dut->b_in = 0;
    //     dut->op_in = 0;
    //     dut->in_valid = 0;
    // }
}

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vbyte_accumulator *dut = new Vbyte_accumulator;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    int clk = 0;
    while (sim_time < MAX_SIM_TIME) {
        dut_reset(dut, sim_time);

        clk ^= 1;
        dut->eval();

        if (clk == 1){
            posedge_cnt++;

            // Check previous outputs
            vluint8_t a = (dut->op0_value & 0xFF000000) >> 24;
            vluint8_t b = (dut->op0_value & 0x00FF0000) >> 16;
            vluint8_t c = (dut->op0_value & 0x0000FF00) >> 8;
            vluint8_t d = (dut->op0_value & 0x000000FF);
            // printf("DEBUG: %d + %d + %d + %d = %d\n", a, b, c, d, dut->acc_out);

            vluint8_t expected = a + b + c + d;
            if (expected != dut->acc_out) {
                printf("ERROR: cycle %llu \n\t%d + %d + %d + %d \n\texpected: %d\n\tout: %d\n", posedge_cnt, a, b, c, d, expected, dut->acc_out);
            }

            // Set new inputs
            dut->op0_value = rand();
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
